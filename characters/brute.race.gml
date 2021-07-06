#define init
	global.sprIdle = sprite_add("../sprites/Characters/Brute/sprBruteIdle.png", 18, 12, 12);
	global.sprWalk = sprite_add("../sprites/Characters/Brute/sprBruteWalk.png", 10, 12 , 12);
	global.sprHurt = sprite_add("../sprites/Characters/Brute/sprBruteHurt.png", 3, 12, 12);
	global.sprDead = sprite_add("../sprites/Characters/Brute/sprBruteDead.png", 6, 12 , 12);
	global.sprPort = sprite_add("../sprites/Characters/Brute/sprBrutePortrait.png", 1, 40, 231);
	global.sprHand = sprite_add("../sprites/Characters/Brute/sprHand.png", 1, 12, 12);
	
	 // Reapply sprites if the mod is reloaded. we should add this to our older race mods //
	with(instances_matching(Player, "race", mod_current)) { 
		assign_sprites();
		assign_sounds();
	}
	
#define race_name
	return "BRUTE";

#define race_text
	return "CAN ONLY DIE AT @r1 HP@w#IS SLOWER#CAN @rPUNCH@w";

#define race_tb_text
	return "@dNYI@s";

#define race_portrait
	return global.sprPort;

#define race_soundbank
	return 7;

#define race_ultra_name
	switch(argument0){
		case 1: return "ULTRA A";
		case 2: return "ULTRA B";
	}

#define race_ultra_text 
	switch (argument0){
		case 1: return "@dNYI@s";
		case 2: return "@dNYI@s";
	}

#define create
	assign_sprites();
	
	maxspeed -= 0.5;
	
	fist_chrg = 0;
	chrg_max  = 4;
	chrg_mult = 0.06;
	
	brutedie = 1;

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
				brutedie = 0;
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
			fist_chrg += chrg_mult;
			
			sound_play_pitchvol(sndJackHammer, 0.2 + (fist_chrg/chrg_max) + random(0.1), 0.4);
			if(fist_chrg > 2) {
				sound_play_pitchvol(sndSnowTankShoot, 1.4 + (fist_chrg/chrg_max) + random(0.1), 0.4)
			}
			
			if(fist_chrg >= chrg_max) {
				fist_chrg = chrg_max;
				sound_play_pitch(sndSwapMotorized, 0.6 + random(0.2));
				sound_play_pitch(sndSwapBow, 0.4 + random(0.2));
				
				with(instance_create(x, y, ImpactWrists)) {
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
					with(instances_meeting(x, y, [projectile, hitme])) {
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
									_hit[2] += 1;
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
						with(instance_create(x, y, Dust)) {
							motion_add(other.gunangle + 180 + orandom(10), 4 + random(4));
						}
					}
					
					if(_hit[1]) {
						if(random(4) < 1) instance_create(x, y, BloodStreak).image_angle = gunangle + orandom(10);
					}
				}
				
				if(_hit[0]) {
					sound_play_pitch(sndHitWall, 1.4 + random(0.4));
					sound_play_pitch(sndMeleeWall, 1.4 + random(0.4));
					sound_play_pitch(sndBoltHitWall, 0.8 + random(0.4));
				}
				
				if(_hit[2]) {
					repeat(3) instance_create(x, y, AllyDamage);
					
					my_health += min(maxhealth - my_health, _hit[1]);
					
					sound_play_pitch(sndHitFlesh, 0.6 + random(0.2));
					sound_play_pitch(sndBigMaggotHit, 0.8 + random(0.2));
					sound_play_pitch(sndAllyHurt, 1.6 + random(0.2));
					sound_play_pitch(sndSharpTeeth, 0.5 + random(0.2));
				}
				
				with(instances_in_rectangle(x - 48, y - 48, x + 48, y + 48, projectile)) {
					if(team != other.team) instance_destroy();
				}
				
				with(projectile_create(self, x + hspeed, y + vspeed, _hit[2] ? BloodSlash : Slash, gunangle, speed * 0.5)) {
					damage = 4;
					if(instance_is(self, BloodSlash)) damaged = 1;
				}
				
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
	draw_sprite_ext(global.sprHand, 0, x - lengthdir_x(fist_chrg * 2, gunangle) + (orandom(fist_chrg) * 0.40), y - lengthdir_y(fist_chrg * 2, gunangle) + (orandom(fist_chrg) * 0.40), 1, right, gunangle, image_blend, abs(fist_chrg)/chrg_max);

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

#define orandom(_num)
	return mod_script_call("mod", "relics", "orandom", _num);

#define instances_meeting(_x, _y, _obj)
	return mod_script_call("mod", "relics", "instances_meeting", _x, _y, _obj);
	
#define instances_in_rectangle(_x1, _y1, _x2, _y2, _obj)
	return mod_script_call("mod", "relics", "instances_in_rectangle", _x1, _y1, _x2, _y2, _obj);
	
#define projectile_create(_inst, _x, _y, _obj, _dir, _spd)
	return mod_script_call("mod", "relics", "projectile_create", _inst, _x, _y, _obj, _dir, _spd);

