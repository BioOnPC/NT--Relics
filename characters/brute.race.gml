#define init
	global.sprIdle   = sprite_add("../sprites/Characters/Brute/sprBruteIdle.png", 18, 12, 12);
	global.sprWalk   = sprite_add("../sprites/Characters/Brute/sprBruteWalk.png", 10, 12 , 12);
	global.sprHurt   = sprite_add("../sprites/Characters/Brute/sprBruteHurt.png", 3, 12, 12);
	global.sprDead   = sprite_add("../sprites/Characters/Brute/sprBruteDead.png", 6, 12 , 12);
	global.sprPort   = sprite_add("../sprites/Characters/Brute/sprBrutePortrait.png", 1, 40, 231);
	global.sprSelect = sprite_add("../sprites/Characters/Brute/sprBruteSelect.png", 1, 0, 0);
	global.sprMap    = sprite_add("../sprites/Characters/Brute/sprBruteMap.png", 1, 10, 10);
	global.sprHand   = sprite_add("../sprites/Characters/Brute/sprHand.png", 4, 8, 8);
	
	 // Reapply sprites if the mod is reloaded. we should add this to our older race mods //
	with(instances_matching(Player, "race", mod_current)) { 
		assign_sprites();
		assign_sounds();
	}
	
#define race_name
	return "BRUTE";

#define race_text
	return "IS SLOWER#CAN ONLY DIE AT @r1 HP@w#CAN @rPUNCH@w";

#define race_tb_text
	return "@gNUCLEAR@s PUNCH";

#define race_tb_take(_pick)
	with(instances_matching(Player, "race", "brute")) {
		if(_pick) {
			chrg_max  = 8;
			chrg_mult = 0.1 * _pick;
		}
		
		else {
			chrg_max = 4;
			chrg_mult = 0.06;
		}
	}

#define race_portrait
	return global.sprPort;

#define race_menu_button
	sprite_index = global.sprSelect;

#define race_soundbank
	return 7;

#define race_ultra_name
	switch(argument0){
		case 1: return "RUSHDOWN";
		case 2: return "ULTRA B";
		case 3: if(mod_exists("mod", "metamorphosis")) return "ULTRA C";
		case 4: if(mod_exists("mod", "LOMutsSprites")) return "ULTRA D";
	}

#define race_ultra_text 
	switch (argument0){
		case 1: return "@rPUNCH KILLS@s GRANT @wINVULNERABILITY@s#@dNYI@s";
		case 2: return "@wABSORB@s AND @wRETURN@s#BULLETS DESTROYED BY YOUR @rPUNCH@s#@dNYI@s";
		case 3: if(mod_exists("mod", "metamorphosis")) return "@wSTUN@s NEARBY ENEMIES#AFTER TAKING @rLETHAL DAMAGE@s#@dNYI@s";
		case 4: if(mod_exists("mod", "LOMutsSprites")) return "@dNYI@s";
	}
	
#define race_mapicon
	return global.sprMap;

#define race_ttip
	 // ULTRA TIPS //
	if(instance_exists(GameCont) and GameCont.level >= 10 and random(5) < 1) return choose("THE CYCLE OF VIOLENCE", "WARMONGER", "IT BEGINS AGAIN", "A BREAK WOULD BE NICE", "YOU'LL NEVER BE SATISFIED");
	
	 // NORMAL TIPS //
	else return choose("BREAK IT DOWN", "READYING A @rPUNCH@s#SLOWS YOU DOWN", "@rPUNCH@s KILLS HEAL YOU", "END IT", "CARNAGE", "BLITZKRIEG", "WASTELAND HIERARCHY", "SHOW YOUR STRENGTH", "NO INSECURITY", "YOU'LL NEVER BE SAFE");

#define create
	assign_sprites();
	
	maxspeed -= 0.5;
	
	fist_chrg = 0;
	chrg_max  = (skill_get(mut_throne_butt) ? 8 : 4);
	chrg_mult = (skill_get(mut_throne_butt) ? 0.1 : 0.06);
	
	brutedie = 1;
	
	footkind = 3; // cool footstep sounds

#define step
	if(fork()) {
		var _prevhp = my_health;
		wait 0;
		if(!instance_exists(self)) exit;
		
		if(my_health <= 1 and _prevhp > 1) {
			my_health = 1;
			brutedie  = -1; // For visuals
			
			if(fork()) { // weird visual workaround
				wait 2;
				if(instance_exists(self)) brutedie = 0;
				exit;
			}
			
			with(instance_create(x - hspeed, y - vspeed, BloodGamble)) {
				image_angle = other.direction + orandom(30);
				image_xscale = 1.2;
				image_yscale = 0.4;
				image_speed  = 0.35;
			}
			
			sound_play_pitch(sndPlantTBKill, 0.4 + random(0.2));
			sound_play_pitch(sndPlantSnareTB, 0.6 + random(0.2));
			sound_play_pitch(sndExploGuardianHurt, 0.6 + random(0.2));
		}
		
		exit;
	}
	
	if(my_health > 1 and !brutedie) brutedie = 1;
	
	
	if(canspec and (button_check(index, "spec") or usespec)) {
		if(button_pressed(index, "spec")) {
			fist_chrg = 0;
		}
		
		if(fist_chrg < chrg_max) {
			var diff = fist_chrg
			fist_chrg += chrg_mult;
			
			if(diff < 2 and fist_chrg >= 2) {
				sound_play_pitch(sndEmpty, 1.4 + random(0.4));
				sound_play_pitch(sndSwapBow, 1.4 + random(0.4));
				
				with(instance_create(x, y, ImpactWrists)) {
					depth = depth - 1;
					image_xscale = 0.5;
					image_yscale = 0.5;
				}
			}
			
			if(skill_get(mut_throne_butt) and (diff < 4 and fist_chrg >= 4)) {
				sound_play_pitch(sndUltraGrenadeSuck, 1.4 + random(0.4));
				sound_play_pitch(sndSwapEnergy, 0.6 + random(0.2));
				sound_play_pitch(sndDevastatorExplo, 1.8 + random(0.4));
				
				with(instance_create(x, y, ImpactWrists)) {
					depth = depth - 1;
					image_xscale = 0.75;
					image_yscale = 0.75;
				}
			}
			
			sound_play_pitchvol(sndJackHammer, 0.2 + (fist_chrg/chrg_max) + random(0.1), 0.4);
			if(fist_chrg > 2) {
				sound_play_pitchvol(sndSnowTankShoot, 1.4 + (fist_chrg/chrg_max) + random(0.1), 0.4)
			}
			
			if(fist_chrg >= chrg_max) {
				fist_chrg = chrg_max;
				sound_play_pitch(sndSwapMotorized, 0.6 + random(0.2));
				sound_play_pitch(sndSwapBow, 0.4 + random(0.2));
				if(skill_get(mut_throne_butt)) {
					sound_play_pitch(sndGunGun, 0.6 + random(0.2));
					sound_play_pitchvol(sndSwapCursed, 0.6 + random(0.2), 2);
				}
				
				with(instance_create(x, y, ChickenB)) {
					depth = depth - 1;
					image_speed = 0.5;
				}
			}
		}
	}
	
	else {
		if(fist_chrg > 0) {
			if(fist_chrg > 2 and button_released(index, "spec")) {
				var _hit = [0, 0, 0]; // projectiles, hitmes, kills
				repeat(24 * (fist_chrg/chrg_max)) {
					move_contact_solid(gunangle, 8);
					xprevious = x;
					yprevious = y;
					with(call(scr.instances_meeting, x, y, [projectile, hitme])) {
						if(team != other.team) {
							if(instance_is(self, projectile)) {
								_hit[0] = 1;
								instance_create(x, y, EBulletHit);
								instance_destroy();
							}
							
							else {
								projectile_hit_push(self, ceil(6 + (2 * (instance_exists(GameCont) ? GameCont.level * GameCont.loops : 1)) * (other.fist_chrg/other.chrg_max)), 4);
								_hit[1] = 1;
								
								if(my_health <= 0) {
									if("brutehit" not in self) {
										_hit[2] += 1;
										brutehit = true;
									}
								}
								
								with(instance_create(x - hspeed, y - vspeed, BloodGamble)) {
									image_angle = other.direction + orandom(30);
									image_xscale = 1.2;
									image_yscale = 0.4;
									image_speed  = 0.35;
								}
							}
						}
					}
					
					repeat(1 + irandom(2)) {
						with(instance_create(x, y, skill_get(mut_throne_butt) ? Smoke : Dust)) {
							motion_add(other.gunangle + 180 + orandom(10), 4 + random(4));
						}
					}
					
					if(_hit[1]) {
						if(random(4) < 1) instance_create(x, y, skill_get(mut_throne_butt) ? AcidStreak : BloodStreak).image_angle = gunangle + orandom(10);
					}
					
					with(call(scr.instances_in_rectangle, x - 25,y - 25,x + 25,y + 25, Rad)){
						move_contact_solid(other.gunangle, 2);
						motion_add(other.gunangle,4/power(sqr(x-other.x) + sqr(y-other.y), 0.25));
						speed = min(speed, 12);
					}
				}
				
				if(_hit[0]) {
					sound_play_pitch(sndHitWall, 1.4 + random(0.4));
					sound_play_pitch(sndMeleeWall, 1.4 + random(0.4));
					sound_play_pitch(sndBoltHitWall, 0.8 + random(0.4));
				}
				
				if(_hit[2]) {
					repeat(3) instance_create(x, y, AllyDamage);
					
					with(instance_create(x, y, PopupText)) {
						mytext = other.maxhealth - other.my_health < _hit[2] ? "MAX HP" : `+${_hit[2]} HP`
					}
					
					my_health += min(maxhealth - my_health, _hit[2]);
					
					sound_play_pitch(sndHitFlesh, 0.6 + random(0.2));
					sound_play_pitch(sndBigMaggotHit, 0.8 + random(0.2));
					sound_play_pitch(sndAllyHurt, 1.6 + random(0.2));
					sound_play_pitch(sndSharpTeeth, 0.5 + random(0.2));
				}
				
				with(call(scr.instances_in_rectangle, x - 48, y - 48, x + 48, y + 48, projectile)) {
					if(team != other.team) instance_destroy();
				}
				
				with(call(scr.projectile_create, self, x + hspeed, y + vspeed, _hit[2] ? BloodSlash : Slash, gunangle, speed * 0.5)) {
					damage = 4;
					if(instance_is(self, BloodSlash)) damaged = 1;
				}
				
				if(skill_get(mut_throne_butt) and fist_chrg >= chrg_max) {
					repeat(skill_get(mut_throne_butt)) {
						with(instance_create(x, y, GreenExplosion)) {
							team = other.team;
						}
						
						repeat(3) with(instance_create(x, y, SmallExplosion)) {
							team = other.team;
						}
					}
					
					sound_play_pitch(sndExplosionL, 0.6 + random(0.2));
					sound_play_pitch(sndUltraGrenade, 1.2 + random(0.4));
					sound_play_pitch(sndUltraEmpty, 0.4 + random(0.2));
				}
				
				motion_add(gunangle, maxspeed);
				
				sound_play_pitch(sndNadeReload, 0.7 + random(0.2));
				sound_play_pitch(sndSuperFlakExplode, 1.4 + random(0.2));
				sound_play_pitch(sndFlameCannon, 1.7 + random(0.2));
				
				fist_chrg = -20;
			}
			
			else {
				fist_chrg -= max(lerp(fist_chrg, 0, 0.05), 0.25);
				
				if(fist_chrg <= 0) {
					fist_chrg = 0;
					sound_play_pitch(sndClickBack, 1.4 + random(0.4));
					with(instance_create(x, y, WepSwap)) {
						depth = depth - 1;
						image_speed = 0.5;
					}
				}
			}
		}
		
		else if(fist_chrg < 0) {
			fist_chrg += max(0.5, abs(fist_chrg) * 0.25);
			
			if(fist_chrg >= 0) {
				fist_chrg = 0;
				sound_play_pitch(sndPickupDisappear, 1.4 + random(0.4));
				with(instance_create(x, y, WepSwap)) {
					depth = depth - 1;
					image_speed = 0.5;
				}
			}
		}
	}
	
	if(fist_chrg > 0) {
		speed = clamp(speed, speed, maxspeed - (fist_chrg * 0.25));
	}

#define draw
	var pos = [x - lengthdir_x(fist_chrg * 2, gunangle) + (orandom(fist_chrg) * 0.40), y - lengthdir_y(fist_chrg * 2, gunangle) + (orandom(fist_chrg) * 0.40)];

	draw_sprite_ext(global.sprHand, (min(abs(fist_chrg), 1)/1) * 3, pos[0], pos[1], 1, right, gunangle + (fist_chrg * 3), image_blend, abs(fist_chrg)/0.75);
	draw_sprite_ext(sprGroundFlameBig, -1, pos[0], pos[1] - 3, right, image_yscale, image_angle, c_lime, (fist_chrg - 4)/chrg_max);

#define assign_sprites
	if(object_index = Player) {
		spr_idle = global.sprIdle//[bskin];
		spr_walk = global.sprWalk//[bskin];
		spr_hurt = global.sprHurt//[bskin];
		spr_dead = global.sprDead//[bskin];
		//spr_sit2 = global.sprSit[bskin];
		//spr_sit1 = global.sprGoSit[bskin];
	}
	
	/*else if("name" in self and name = "EffigyOrbital") {
		spr_idle = global.sprOrbital[type];
		spr_glow = global.sprOrbitalGlow[type];
		spr_dead = global.sprOrbitalDie;
	}*/

#define assign_sounds
	/*snd_hurt = snd.EffigyHurt;
	snd_dead = snd.EffigyDead;
	snd_lowa = snd.EffigyLowAM;
	snd_lowh = snd.EffigyLowHP;
	snd_wrld = snd.EffigyWorld;
	snd_crwn = snd.EffigyConfirm;
	snd_chst = snd.EffigyChest;
	snd_valt = snd.EffigyVault;
	snd_thrn = snd.EffigyVault;
	snd_spch = snd.EffigyThrone;
	snd_idpd = snd.EffigyIDPD;
	snd_cptn = snd.EffigyCaptain;*/

#macro  scr																						mod_variable_get("mod", "relics", "scr")
#macro  call																					script_ref_call
#define orandom(_num)
	return mod_script_call("mod", "relics", "orandom", _num);

