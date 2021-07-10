#define init
	if(fork()) {
		while(!mod_exists("mod", "lib")){wait(1);}
		mod_script_call("mod", "lib", "import", "libGeneral");
		while(!mod_exists("mod", "libGeneral")){wait(1);}
		call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	
		call(scr.obj_setup, mod_current, ["AnglerFish", "CubeGuardian", "EliteSniperDeath", "EliteSniper", "RelicsPlasma", "Guppy", "HeavyBandit", "HellKnight", "HellTorch", "Imp", "Jelly", "KnightQuake", "PlasmaEye", "SmallDog", "SodaBullet", "SodaMimic", "ShieldSpider"]);
	}

	global.spr = {};
	
	with(spr) {
		var _p = "sprites/",
			_s = "";
		
		//#region AREAS
			_s = _p + "Areas/";
			
			//#region CASTLE
				 // MISC
                CastleIcon   = sprite_add(_s + "Castle/sprCastleIcon.png", 1, 8, 4);
                CastleDetail = sprite_add(_s + "Castle/sprDetail.png",    5, 4, 4);
                CastleDebris = sprite_add(_s + "Castle/sprDebris.png",    4, 4, 4);
			
				 // FLOOR
                CastleDecal      = sprite_add(_s + "Castle/sprDecal.png",		 2,  8, 24);
                CastleFloor      = sprite_add(_s + "Castle/sprFloor.png",      4,  0,  0);
                CastleFloorB     = sprite_add(_s + "Castle/sprFloorB.png",     4,  8,  8);
                CastleFloorExplo = sprite_add(_s + "Castle/sprFloorExplo.png", 4,  1,  1);
                
                 // WALLS
                CastleTopDecal   = sprite_add(_s + "Castle/sprTopDecal.png",    3, 16, 16);
                CastleWallBot    = sprite_add(_s + "Castle/sprWallBot.png",    4,  0,  0);
                CastleWallOut    = sprite_add(_s + "Castle/sprWallOut.png",    1,  4,  8);
                CastleWallTop    = sprite_add(_s + "Castle/sprWallTop.png",    4,  0,  0);
                CastleWallTrans  = sprite_add(_s + "Castle/sprWallTrans.png",  3,  0,  0);
                
                 // TORCHES
                OldTorch     = sprite_add(_s + "Castle/sprTorch.png",     4, 12, 14);
                OldTorchHurt = sprite_add(_s + "Castle/sprTorchHurt.png", 3, 12, 14);
                OldTorchDead = sprite_add(_s + "Castle/sprTorchDead.png", 5, 12, 14);
                
                TorchUnlit     = sprite_add(_s + "Castle/sprTorchUnlit.png",     1, 12, 14);
                TorchUnlitHurt = sprite_add(_s + "Castle/sprTorchUnlitHurt.png", 3, 12, 14);
			//#endregion
		//#endregion
		
		//#region ENEMIES
			_s = _p + "Enemies/";
		
			//#region DESERT
				 // Heavy Bandit
				HeavyBanditIdle = sprite_add(_s + "HeavyBandit/sprHeavyBanditIdle.png", 4, 12, 12);
				HeavyBanditWalk = sprite_add(_s + "HeavyBandit/sprHeavyBanditWalk.png", 6, 12, 12);
				HeavyBanditHurt = sprite_add(_s + "HeavyBandit/sprHeavyBanditHurt.png", 3, 12, 12);
				HeavyBanditDead = sprite_add(_s + "HeavyBandit/sprHeavyBanditDead.png", 7, 12, 12);
			//#endregion
			
			//#region SCRAPYARD
				 // Elite Sniper
				EliteSniperIdle = sprite_add(_s + "EliteSniper/sprEliteSniperIdle.png", 4, 16, 16);
				EliteSniperWalk = sprite_add(_s + "EliteSniper/sprEliteSniperWalk.png", 6, 16, 16);
				EliteSniperHurt = sprite_add(_s + "EliteSniper/sprEliteSniperHurt.png", 3, 16, 16);
				EliteSniperDead = sprite_add(_s + "EliteSniper/sprEliteSniperDead.png", 6, 16, 16);
				EliteSniperWeap = sprite_add(_s + "EliteSniper/sprEliteSniperRifle.png", 1, 17, 6);
				
				 // Small Dog
				SmallDogIdle = sprite_add(_s + "SmallDog/sprSmallDogIdle.png", 6, 12, 12);
				SmallDogWalk = sprite_add(_s + "SmallDog/sprSmallDogWalk.png", 6, 12, 12);
				SmallDogHurt = sprite_add(_s + "SmallDog/sprSmallDogHurt.png", 3, 12, 12);
				SmallDogDead = sprite_add(_s + "SmallDog/sprSmallDogDead.png", 6, 12, 12);
			//#endregion
			
			//#region CRYSTAL CAVES
				 // Shield Spider
				ShieldSpiderIdle		 = sprite_add(_s + "ShieldSpider/sprShieldSpiderIdle.png", 6, 24, 24);
				ShieldSpiderWalk		 = sprite_add(_s + "ShieldSpider/sprShieldSpiderWalk.png", 6, 24, 24);
				ShieldSpiderHurt		 = sprite_add(_s + "ShieldSpider/sprShieldSpiderHurt.png", 3, 24, 24);
				ShieldSpiderDead		 = sprite_add(_s + "ShieldSpider/sprShieldSpiderDead.png", 6, 24, 24);
				ShieldSpiderShield  	 = sprite_add(_s + "ShieldSpider/sprShieldSpiderShield.png", 9, 24, 24);
				ShieldSpiderShielded     = sprite_add(_s + "ShieldSpider/sprShieldSpiderShielded.png", 1, 24, 24);
				ShieldSpiderShieldedHurt = sprite_add(_s + "ShieldSpider/sprShieldSpiderShieldedHurt.png", 3, 24, 24);
				ShieldSpiderOff     	 = sprite_add(_s + "ShieldSpider/sprShieldSpiderShieldOff.png", 3, 24, 24);
			//#endregion
			
			//#region FROZEN CITY
				 // Soda Mimic
				SodaMimicIdle = sprite_add(_s + "SodaMimic/sprSodaMimicIdle.png", 1, 16, 16);
				SodaMimicWalk = sprite_add(_s + "SodaMimic/sprSodaMimicWalk.png", 4, 16, 16);
				SodaMimicHurt = sprite_add(_s + "SodaMimic/sprSodaMimicHurt.png", 3, 16, 16);
				SodaMimicDead = sprite_add(_s + "SodaMimic/sprSodaMimicDead.png", 6, 16, 16);
				SodaMimicTell = sprite_add(_s + "SodaMimic/sprSodaMimicTell.png", 13, 16, 16);
			//#endregion
			
			//#region PALACE
				 // Cube Guardian
				CubeGuardianWalk		 = sprite_add(_s + "CubeGuardian/sprCubeGuardianWalk.png", 6, 32, 32);
				CubeGuardianHurt		 = sprite_add(_s + "CubeGuardian/sprCubeGuardianHurt.png", 3, 32, 32);
				CubeGuardianDead		 = sprite_add(_s + "CubeGuardian/sprCubeGuardianDead.png", 9, 32, 32);
				CubeGuardianFireStart  	 = sprite_add(_s + "CubeGuardian/sprCubeGuardianFireStart.png", 9, 32, 64);
				CubeGuardianFire         = sprite_add(_s + "CubeGuardian/sprCubeGuardianFire.png", 4, 32, 64);
				CubeGuardianFireHurt     = sprite_add(_s + "CubeGuardian/sprCubeGuardianFireHurt.png", 4, 32, 64);
				CubeGuardianFireEnd      = sprite_add(_s + "CubeGuardian/sprCubeGuardianFireEnd.png", 9, 32, 64);
			//#endregion
			
			//#region CASTLE
        		 // Imp
                ImpIdle   = sprite_add(_s + "Imp/sprImpIdle.png",   4, 16, 20);
                ImpDash   = sprite_add(_s + "Imp/sprImpDash.png",   8, 24, 24);
                ImpHurt   = sprite_add(_s + "Imp/sprImpHurt.png",   3, 16, 20);
                ImpDead   = sprite_add(_s + "Imp/sprImpDead.png",   6, 16, 20);
                Pitchfork = sprite_add(_s + "Imp/sprPitchfork.png", 1,  9,  6);
                
                
                 // Eye
                EyeIdle = sprite_add(_s + "Eye/sprEyeIdle.png",     8, 12, 12);
                EyeHurt = sprite_add(_s + "Eye/sprEyeHurt.png",     3, 12, 12);
                EyeDead = sprite_add(_s + "Eye/sprEyeDead.png",     6, 12, 12);
                
                RelicsPlasma       = sprite_add(_s + "Eye/sprEnemyPlasma.png",       2, 12, 12);
                RelicsPlasmaImpact = sprite_add(_s + "Eye/sprEnemyPlasmaImpact.png", 7, 16, 16);
                RelicsPlasmaTrail  = sprite_add(_s + "Eye/sprEnemyPlasmaTrail.png",  3,  4,  4);
                
                 // Knight
                KnightIdle   = sprite_add(_s + "Knight/sprKnightIdle.png",   6, 26, 24);
                KnightWalk   = sprite_add(_s + "Knight/sprKnightWalk.png",   8, 26, 24);
                KnightHurt   = sprite_add(_s + "Knight/sprKnightHurt.png",   3, 26, 24);
                KnightDead   = sprite_add(_s + "Knight/sprKnightDead.png",   5, 26, 24);
                KnightSword  = sprite_add(_s + "Knight/sprKnightSword.png",  1,  2,  5);
			
			//#endregion
			
			//#region DROWNED CITY
				 // Anglerfish
				AnglerFishIdle = sprite_add(_s + "AnglerFish/sprAnglerFishIdle.png", 11, 15, 18);
				AnglerFishWalk = sprite_add(_s + "AnglerFish/sprAnglerFishWalk.png", 6, 15, 19);
				AnglerFishHurt = sprite_add(_s + "AnglerFish/sprAnglerFishHurt.png", 3, 15, 18);
				AnglerFishDead = sprite_add(_s + "AnglerFish/sprAnglerFishDead.png", 6, 15, 18);
			
				 // Blowfish
				BlowFishIdle = sprite_add(_s + "BlowFish/sprBlowFishIdle.png", 4, 12, 12);
				BlowFishWalk = sprite_add(_s + "BlowFish/sprBlowFishWalk.png", 6, 12, 12);
				BlowFishHurt = sprite_add(_s + "BlowFish/sprBlowFishHurt.png", 3, 12, 12);
				
				 // Guppy
				GuppyIdle = sprite_add(_s + "Guppy/sprGuppyIdle.png", 6, 12, 12);
				GuppyHurt = sprite_add(_s + "Guppy/sprGuppyHurt.png", 3, 12, 12);
				GuppyDead = sprite_add(_s + "Guppy/sprGuppyDead.png", 11, 12, 12); 
				
				 // Jelly
				JellyIdle = sprite_add(_s + "Jelly/sprJellyIdle.png", 12, 32, 32);
				JellyHurt = sprite_add(_s + "Jelly/sprJellyHurt.png", 3, 32, 32);
				JellyDead = sprite_add(_s + "Jelly/sprJellyDead.png", 7, 32, 32);
			//#endregion
		
		//#endregion
	}
	
	 // List of area variants:
	global.area_variants = [];
	
	var _mod = mod_get_names("mod"),
		_scr = "init_variants";
	
	 // Go through all of the mods loaded and execute their init_variants script:
	for(i = 0; i < array_length(_mod); i++) {
		if(mod_script_exists("mod", _mod[i], _scr)) {
			mod_script_call("mod", _mod[i], _scr);
		}
	}
	
	global.level_loading = false;
	
	if(fork()) {
    	wait 3;
    	
    	repeat(17) trace("");
    	trace_color("Thanks for playing Relics!", c_maroon);
    	trace_color("This mod is still in beta, so make sure to let tildebee in the NT discord (discord.gg/nt) know if you find any bugs!", c_aqua);
    	exit;
    }

#define init_variants
	area_variant_add(50, 1, "night desert", ["so cold", "cold-blooded", "ambush", "so quiet"], -1, -1, -1);

#define level_start
	if(instance_exists(GameCont) and GameCont.area = 101) with(instances_matching(Crab, "jellified", null)) {
		jellified = true;
		if(chance(1, 3)) call(scr.obj_create, x, y, "Jelly");
	}
	
	with(instances_matching(SodaMachine, "mimicified", null)) {
		mimicified = true;
		if(chance(1, 10)) {
			call(scr.obj_create, x, y, "SodaMimic");
			instance_delete(self);
		}
	}
	
	with(instances_matching(Raven, "smalldogified", null)) {
		smalldogified = true;
		if(chance(1, 5)) {
			call(scr.obj_create, x, y, "SmallDog");
			instance_delete(self);
		}
	}
	
	with(instances_matching(ExploGuardian, "cubed", null)) {
		cubed = true;
		if(chance(1, 3)) {
			call(scr.obj_create, x, y, "CubeGuardian");
			instance_delete(self);
		}
	}
	
	with(instances_matching(Sniper, "eliteified", null)) {
		eliteified = true;
		if(chance(1 + (instance_exists(GameCont) ? GameCont.loops * 3 : 0), 20)) {
			call(scr.obj_create, x, y, "EliteSniper");
			instance_delete(self);
		}
	}
	
	with(instances_matching(Bandit, "eliteified", null)) {
		eliteified = true;
		if(instance_exists(GameCont) and GameCont.area = 1 and chance(min(1 + (instance_exists(GameCont) ? GameCont.loops * 3 : 0), 10), 20)) {
			call(scr.obj_create, x, y, "HeavyBandit");
			instance_delete(self);
		}
	}
	
	with(instances_matching(Spider, "eliteified", null)) {
		eliteified = true;
		if(chance(1 + (instance_exists(GameCont) ? GameCont.loops * 3 : 0), 20)) {
			call(scr.obj_create, x, y, "ShieldSpider");
			instance_delete(self);
		}
	}
	

	if(instance_exists(GameCont) and GameCont.area = 7 and GameCont.subarea = 1) {
		with(instances_matching([Pillar, SmallGenerator], "", null)) {
			if(array_length(instances_matching(CustomHitme, "name", "HellTorch")) = 0) {
				with(call(scr.obj_create, x, y, "HellTorch")) name = "HellTorch";
				
				instance_delete(self);
			}
		}
	}

#define step
	if(instance_exists(GenCont) || instance_exists(Menu)){
        global.level_loading = true;
    }
    else if(global.level_loading){
        global.level_loading = false;
        level_start();
    }

#define draw_bloom
	 // Custom Bullets:
	with(instances_matching(CustomProjectile, "name", "RelicsPlasma")){
		draw_sprite_ext(sprite_index, image_index, x, y, 2 * image_xscale, 2 * image_yscale, image_angle, image_blend, 0.1 * image_alpha);
	}

 // Thanks yokin! //
#define draw_gui
     // Player HUD Management:
    if(instance_exists(Player) && !instance_exists(PopoScene) && !instance_exists(MenuGen)){
        if(instance_exists(TopCont) || instance_exists(GenCont) || instance_exists(LevCont)){
            var _hudFade  = 0,
                _hudIndex = 0,
                _lastSeed = random_get_seed();
                
             // Game Win Fade Out:
            if(array_length(instances_matching(TopCont, "fadeout", true))){
                with(TopCont){
                    _hudFade = clamp(fade, 0, 1);
                }
            }
            if(_hudFade > 0){
                 // GMS1 Partial Fix:
                try if(!null){}
                catch(_error){
                    _hudFade = min(_hudFade, round(_hudFade));
                }
                
                 // Dim Drawing:
                if(_hudFade > 0){
                    draw_set_fog(true, c_black, 0, 16000 / _hudFade);
                }
            }
            
             // Draw Player HUD:
            for(var _isOnline = 0; _isOnline <= 1; _isOnline++){
                for(var _index = 0; _index < maxp; _index++){
                    if(
                        player_is_active(_index)
                        && (_hudIndex < 2 || !instance_exists(LevCont))
                        && (player_is_local_nonsync(_index) xor _isOnline)
                    ){
                        var _hudVisible = false;
                        
                         // HUD Visibility:
                        for(var i = 0; true; i++){
                            var _local = player_find_local_nonsync(i);
                            if(!player_is_active(_local)){
                                break;
                            }
                            if(player_get_show_hud(_index, _local)){
                                _hudVisible = true;
                                break;
                            }
                        }
                        
                         // Draw HUD:
                        if(_hudVisible || _isOnline == 0){
                            if(_hudVisible){
                                var _player = player_find(_index);
                                if(instance_exists(_player)){
                                     // Rad Canister / Co-op Offsets:
                                    var _playerNum = 0;
                                    for(var i = 0; i < maxp; i++){
                                        _playerNum += player_is_active(i);
                                    }
                                    if(_playerNum <= 1){
                                        d3d_set_projection_ortho(
                                            view_xview_nonsync - 17,
                                            view_yview_nonsync,
                                            game_width,
                                            game_height,
                                            0
                                        );
                                    }
                                    else draw_set_projection(2, _index);
                                    
                                     // Draw:
                                    player_hud(_player, _hudIndex, _hudIndex % 2);
                                    
                                    draw_reset_projection();
                                }
                            }
                            _hudIndex++;
                        }
                    }
                }
            }
            if(_hudFade > 0){
                draw_set_fog(false, 0, 0, 0);
            }
            random_set_seed(_lastSeed);
        }
    }

#define player_hud(_player, _hudIndex, _hudSide)
    with(_player) {
	    if(race = "brute") {
	    	if(my_health > 1) {
			    draw_set_color(player_get_color(_hudIndex));
			    draw_rectangle(2, 3, 91, 18, 1);
			    draw_set_color(c_white);
	    	}
	    	
	    	else if(brutedie = -1) {
	    		draw_set_color(c_red);
			    draw_rectangle(2, 3, 91, 18, 1);
			    draw_set_color(c_white);
	    	}
	    }
    }

#define draw_dark
	draw_set_color($808080);
	with(instances_matching(CustomEnemy, "name", "AnglerFish")) draw_circle(x + (lengthdir_x(12 * right, image_angle)), y + lengthdir_y(8, image_angle), 8 + random(2), false);

#define draw_dark_end
	draw_set_color($000000);
	with(instances_matching(CustomEnemy, "name", "AnglerFish")) draw_circle(x + (lengthdir_x(12 * right, image_angle)), y + lengthdir_y(8, image_angle), 4 + random(2), false);

#define cleanup
	global.spr = null;

#define AnglerFish_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)) {
		 // Visual:
		spr_idle   = spr.AnglerFishIdle;
		spr_walk   = spr.AnglerFishWalk;
		spr_hurt   = spr.AnglerFishHurt;
		spr_dead   = spr.AnglerFishDead;
		spr_shadow = shd24;
		//spr_shadow_x = -1;
		//spr_shadow_y = ;
		hitid      = [spr_idle, "ANGLER FISH"];
		depth      = -2;

		 // Sound:
		snd_hurt = sndOasisHurt;
		snd_dead = sndOasisDeath;
		
		 // Vars:
		mask_index  = mskBandit;
		maxhealth   = 20;
		raddrop     = 7;
		size        = 1;
		walk	    = 0;
		walkspeed   = 0.8;
		maxspeed    = 3;
		gunangle    = random(360);
		direction   = gunangle;
		charge      = false;
		meleedamage = 4;
		
		 // Alarms:
		alarm1 = 40 + irandom(10);
		
		return self;
	}

#define AnglerFish_step
	enemy_step();
	if(alarm2_run) exit;
	
	if(alarm2) {
		motion_add(gunangle, maxspeed);
		image_angle = gunangle - 90;
		if(chance_ct(3, 4)) {
			sound_play_pitch(sndOasisCrabAttack, 0.6 + random(0.3));
			call(scr.fx, x, y, [direction + 180 + orandom(4), 1 + random(2)], FishBoost);
		}
	}

#define AnglerFish_alrm1
	alarm1 = 40 + irandom(10);
	
	if(enemy_target(x, y) and target_visible) {
		if(target_distance < 108 and chance(2, 3)) {
			alarm1 = 40 + irandom(10);
			gunangle = target_direction + orandom(10);
			
			repeat(4) {
				call(scr.fx, x, y, [gunangle + 180 + orandom(20), 1 + random(2)], FishBoost);
			}
			
			call(scr.fx, x, y, 0, AssassinNotice);
			
			direction = gunangle;
			
			if(fork()) {
				wait 6;
				if(!instance_exists(self)) exit;
				enemy_walk(gunangle, alarm1 - 6);
				alarm2 = walk;
				exit;
			}
			
			sound_play_pitch(sndOasisHorn, 1.1 + random(0.4));
			sound_play_pitch(sndOasisMelee, 0.7 + random(0.4));
			sound_play_pitchvol(sndFishTB, 1.2 + random(0.2), 0.7);
			sound_play_pitch(sndFreakHurt, 0.5 + random(0.3));
		}
		
		else {
			gunangle = target_direction + orandom(30);
			enemy_walk(gunangle, alarm1 - 10);
		}
	}
	
	else {
		gunangle = random(360);
		enemy_walk(gunangle, alarm1 - 10);
	}
	
	enemy_face(direction);

#define AnglerFish_alrm2
	repeat(4) {
		call(scr.fx, x, y, [gunangle + orandom(20), 3 + random(3)], Dust);
	}
	
	image_angle = 0;
	
	sound_play_pitchvol(sndSwapFlame, 2.4 + random(0.2), 0.4);
	sound_play_pitchvol(sndFlameCannonEnd, 2.8 + random(0.2), 0.2);

#define CubeGuardian_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)) {
		 // Visual:
		spr_idle   = spr.CubeGuardianWalk;
		spr_walk   = spr.CubeGuardianWalk;
		spr_hurt   = spr.CubeGuardianHurt;
		spr_dead   = spr.CubeGuardianDead;
		spr_shld   = spr.CubeGuardianFireStart;
		spr_shadow = shd64B;
		spr_shadow_y = 5;
		hitid      = [spr_idle, "CUBE GUARDIAN"];
		depth      = -3;

		 // Sound:
		snd_hurt = sndExploGuardianHurt;
		snd_dead = sndExploGuardianDead;
		snd_mele = sndDogGuardianMelee;
		
		 // Vars:
		mask_index  = mskExploGuardian;
		maxhealth   = 72;
		raddrop     = 30;
		size        = 2;
		walk	    = 0;
		walkspeed   = 0.6;
		maxspeed    = 3.5;
		direction   = random(360);
		meleedamage = 5;
		sucking   = false;
		
		 // Alarms:
		alarm1 = 60 + irandom(15);
		
		return self;
	}

#define CubeGuardian_step
	 // Alarms:
	if("on_alrm0" in self and alarm0_run) exit;
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;
	
	if(!sucking) {
		 // Always moving:
		if(walk <= 0) walk = 1;
		
		 // Movement:
		if(walk > 0){
			walk -= current_time_scale;
			speed += walkspeed * current_time_scale;
		}
		if(speed > maxspeed){
			speed = maxspeed;
		}
	}
	
	else {
		if(sprite_index != spr_fire and chance_ct(1, 2)) {
			sound_play_pitch(sndFrogClose, 1.4 + random(0.2));
			sound_play_pitch(sndPickupDisappear, 1.8 + random(0.4));
			sound_play_pitch(sndGuardianDisappear, 1.4 + random(0.4));
			
			repeat(irandom(3)) with(instance_create(x + orandom(80), y + orandom(80), Dust)) {
				motion_add(point_direction(x, y, other.x, other.y), 4 + random(2));
			}
		}
		
		with(call(scr.instances_in_rectangle, x - 80, y - 80, x + 80, y + 80, Player)) {
			motion_add(point_direction(x, y, other.x, other.y), (point_distance(x, y, other.x, other.y)/80) * 3);
			
			if(chance_ct(1, 2)) repeat(irandom(3)) with(instance_create(x, y, Dust)) {
				motion_add(360, 1 + random(2));
			}
		}
		
		speed = 0;
	}
	
	move_bounce_solid(false);
	
	 // Animate:
	if(sprite_index = spr_fire) {
		if(anim_end) {
			if(spr_fire = spr.CubeGuardianFireStart) {
				spr_idle = spr.CubeGuardianFire;
				spr_hurt = spr.CubeGuardianFireHurt;
				spr_fire = spr.CubeGuardianFireEnd;
			}
			
			else {
				spr_idle = spr.CubeGuardianWalk;
				spr_hurt = spr.CubeGuardianHurt;
				spr_fire = spr.CubeGuardianFireStart;
			}
			
			sprite_index = spr_idle;
		}
	}
	else sprite_index = enemy_sprite;
	
	enemy_face(direction);

#define CubeGuardian_hurt(_damage, _force, _direction)
	my_health -= _damage;           // Damage
	motion_add(_direction, _force); // Knockback
	sound_play_hit(snd_hurt, 0.2);  // Sound
	nexthurt = current_frame + 6;   // I-Frames
	
	if(sprite_index != spr_fire) {
		 // Hurt Sprite:
		sprite_index = spr_hurt;
		image_index  = 0;
	}

#define CubeGuardian_alrm1
	alarm1 = 50 + irandom(20);
	
	if(sprite_index != spr_fire) {
		if(enemy_target(x, y) and target_visible and target_distance < 96) {
			if(chance(1, 3)) {
				alarm1 = 120 + irandom(40);
				alarm2 = alarm1 - 40;
				
				spr_fire = spr.CubeGuardianFireStart;
				sprite_index = spr_fire;
				direction = target_direction;
				
				sucking = true;
				
				sound_play_pitch(sndUltraGrenadeSuck, 1.4 + random(0.2));
				sound_play_pitch(sndCrownGuardianAppear, 1.5 + random(0.2));
				sound_play_pitch(sndEliteGruntRocketFly, 1.4 + random(0.4));
			}
			
			else {
				enemy_walk(target_direction, alarm1 - 15);
			}
		}
		
		else {
			enemy_walk(random(360), alarm1 - 5);
		}
	}

#define CubeGuardian_alrm2
	sprite_index = spr_fire;
	sucking  	 = false;
	sound_play_pitch(sndGuardianDisappear, 1.2 + random(0.2));
	sound_play_pitch(sndGuardianFire, 1.4 + random(0.2));

#define CubeGuardian_death
	repeat(3) pickup_drop(80, 0);

#define EliteSniper_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)) {
		 // Visual:
		spr_idle   = spr.EliteSniperIdle;
		spr_walk   = spr.EliteSniperWalk;
		spr_hurt   = spr.EliteSniperHurt;
		spr_dead   = mskNone;
		spr_weap   = spr.EliteSniperWeap;
		spr_shadow = shd24;
		spr_shadow_y += 2;
		hitid      = [spr_idle, "ELITE SNIPER"];
		depth      = -2;

		 // Sound:
		snd_hurt = sndSniperHit;
		snd_dead = sndSniperHit;
		
		 // Vars:
		mask_index  = mskBanditBoss;
		maxhealth   = 32;
		raddrop     = 14;
		size        = 2;
		walk	    = 0;
		walkspeed   = 0.8;
		maxspeed    = 2;
		gunangle    = random(360);
		direction   = gunangle;
		detonate    = 0;
		
		 // Alarms:
		alarm1 = 40 + irandom(10);
		
		return self;
	}

#define EliteSniper_step
	enemy_step();
	if(alarm2_run) exit;

#define EliteSniper_hurt(_damage, _force, _direction)
	my_health -= _damage;           // Damage
	nexthurt = current_frame + 6;   // I-Frames
	motion_add(_direction, _force); // Knockback
	call(scr.sound_play_at, x, y, snd_hurt, 0.6 + random(0.2), 1, 64, 1);  // Sound
	
	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index  = 0;

#define EliteSniper_alrm1
	alarm1 = 40 + irandom(10);
	
	if(enemy_target(x, y) and target_visible) {
		if(chance(2, 3)) {
			alarm1 = 100 + irandom(20);
			gunangle = target_direction;
			
			alarm2 = 60;
			
			sound_play_pitch(sndSniperTarget, 0.4 + random(0.2));
		}
		
		else {
			gunangle = target_direction + 180 + orandom(50);
			enemy_walk(gunangle, alarm1 - 15);
		}
	}
	
	else {
		gunangle = random(360);
		enemy_walk(gunangle, alarm1 - 15);
	}
	
	enemy_face(gunangle);

#define EliteSniper_alrm2
	if(fork()) {
		var ang = -90;
		repeat(3) {
			call(scr.projectile_create, self, x + (lengthdir_x(12, gunangle + ang) * abs(sign(ang))), y + (lengthdir_y(12, gunangle + ang) * abs(sign(ang))), EnemyBullet4, gunangle, 16);
			ang += 90;
		}
		
		wkick += 10;
		
		sound_play_pitchvol(sndExplosionS, 1.4 + random(0.2), 0.6);
		sound_play_pitch(sndSniperFire, 0.6 + random(0.2));
		sound_play_pitchvol(sndHeavyMachinegun, 0.7 + random(0.1), 0.6);
		
		wait 6;
		
		if(!instance_exists(self)) exit;
		
		gunangle -= 20;
		
		repeat(2) {
			wait 4;
			
			if(!instance_exists(self)) exit;
			
			var ang = -90;
			repeat(3) {
				call(scr.projectile_create, self, x + (lengthdir_x(12, gunangle+ ang) * abs(sign(ang))), y + (lengthdir_y(12, gunangle + ang) * abs(sign(ang))), EnemyBullet4, gunangle, 16);
				ang += 90;
			}
			
			wkick += 4;
			
			sound_play_pitchvol(sndExplosionS, 1.4 + random(0.2), 0.6);
			sound_play_pitch(sndSniperFire, 0.6 + random(0.2));
			sound_play_pitchvol(sndHeavyMachinegun, 0.7 + random(0.1), 0.6);
			
			gunangle += 40;
		}
		
		exit;
	}

#define EliteSniper_draw
	if(alarm2) {
		draw_set_color(make_color_rgb(250, 54, 0));
		draw_lasersight(x, y, gunangle, 1000, 1);
		draw_set_color(c_white);
	}

	draw_self_gun();

#define EliteSniper_death
	call(scr.obj_create, x, y, "EliteSniperDeath").depth = depth;

#define EliteSniperDeath_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)) {
		 // Visual:
		spr_idle	= spr.EliteSniperHurt;
		spr_walk	= spr_idle;
		spr_hurt	= spr_idle;
		spr_dead	= spr.EliteSniperDead;
		spr_shadow  = shd24;
		spr_shadow_y -= 0.2;
		image_speed = 0.4;

		 // Sound:
		snd_hurt = sndHitMetal;
		snd_dead = sndExplosionL;
	
		 // Vars:
		mask_index = mskBanditBoss;
		maxhealth  = 48;
		my_health  = maxhealth;
		maxspeed   = 3;
		friction   = 0.4;
		
		return self;
	}

#define EliteSniperDeath_step
	hitme_step();
	
	if(speed > maxspeed) speed = maxspeed;
	
	if(anim_end) {
		my_health -= 4;
		
		if(!audio_is_playing(sndVanWarning)) {
			sound_play_pitch(sndVanWarning, 0.4);
			if(fork()) {
				wait 4;
				sound_stop(sndVanWarning);
				exit;
			}
		}
	}
	
	 // Die:
	if(my_health <= 0) instance_destroy();
	
#define EliteSniperDeath_hurt(_damage, _force, _direction)
	my_health -= _damage;           // Damage
	nexthurt = current_frame + 6;   // I-Frames
	motion_add(_direction, _force); // Knockback
	sound_play_hit(snd_hurt, 0.2);  // Sound

#define EliteSniperDeath_destroy
	sound_play_pitch(snd_dead, 1 + random(0.2));
	instance_create(x, y, Explosion);
	repeat(3) instance_create(x, y, SmallExplosion);
	corpse_drop(self, direction, max(7, speed));
	repeat(2) pickup_drop(60, 10, 2);

#define RelicsPlasma_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "RelicsPlasma";
		
		 // Visual:
		sprite_index = spr.RelicsPlasma;
		spr_dead     = spr.RelicsPlasmaImpact;
		spr_trail    = spr.RelicsPlasmaTrail;
		image_speed  = 0.5;
		
		 // Sound:
		snd_dead = sndPlasmaHit;
		
		 // Vars:
		mask_index = mskPlasma;
		damage     = 4;
		force      = 4;
		typ        = 2;
		minspeed   = 7;
		minscale   = 0.5;
		
		return self;
	}

#define RelicsPlasma_step
	var	_width = sprite_get_width(sprite_index),
		_minWidth = minscale * _width;
		
	 // Trail:
	if(chance_ct(_width - 16, 16)){
		var	o = _minWidth * ((_width >= 32) ? 3/4 : 1/2);
		with(call(scr.fx, x + orandom(o), y + orandom(o), 0, PlasmaTrail)){
			sprite_index = other.spr_trail;
		}
	}
	
	 // Shake:
	view_shake_max_at(x, y, floor(_width / 24));
		
	 // Explode:
	if(sprite_width < _minWidth || (friction > 0 && speed == 0)){
		instance_destroy();
	}
	
#define RelicsPlasma_draw
	draw_sprite_ext(sprite_index, image_index, x, y, lerp(minscale, 1, image_xscale), lerp(minscale, 1, image_yscale), image_angle, image_blend, image_alpha);
	
#define RelicsPlasma_anim
	image_speed = 0;
	image_index = image_number - 1;
	speed = minspeed;
	
#define RelicsPlasma_hit
	if(projectile_canhit(other)){
		projectile_hit_push(other, round(damage * image_xscale), force);
		
		 // Shrink:
		image_xscale -= 0.1;
		image_yscale -= 0.1;
		x -= hspeed_raw;
		y -= vspeed_raw;
		
		 // Effects:
		var	_sleep = (10 / 3) * floor(sprite_width / 16),
			_shake = 2 + (4 * floor(sprite_get_width(sprite_index) / 32));
		
		if(!instance_is(creator, Player)){
			_sleep *= 3;
			_shake *= 0.5;
		}
		
		sleep(_sleep);
		view_shake_at(x, y, _shake);
	}
	
#define RelicsPlasma_wall
	 // Shrink:
	image_xscale -= 0.1;
	image_yscale -= 0.1;
	x -= hspeed_raw;
	y -= vspeed_raw;
	
	 // Effects:
	call(scr.fx, x, y, 0, Dust);
	sound_play_hit(sndHitWall, 0.2);
	
#define RelicsPlasma_destroy
	sound_play_hit_big(snd_dead, 0.3);
	
	with(call(scr.projectile_create, self, x, y, PlasmaImpact, 0, 0)){
		sprite_index = other.spr_dead;
		if(!instance_is(creator, Player)){
			mask_index = mskPopoPlasmaImpact;
		}
	}
	sleep(3);

#define Guppy_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)) {
		 // Visual:
		spr_idle   = spr.GuppyIdle;
		spr_walk   = spr_idle;
		spr_hurt   = spr.GuppyHurt;
		spr_dead   = spr.GuppyDead;
		spr_shadow = shd16;
		hitid      = [spr_idle, "GUPPY"];
		depth      = -2;

		 // Sound:
		snd_hurt = sndOasisHurt;
		snd_dead = sndOasisDeath;
		
		 // Vars:
		mask_index  = mskBigRad;
		maxhealth   = 8;
		raddrop     = 3;
		size        = 0;
		walk	    = 0;
		walkspeed   = 0.4;
		maxspeed    = 2.8;
		direction   = random(360);
		meleedamage = 2;
		
		 // Alarms:
		alarm1 = 30 + irandom(15);
		
		return self;
	}

#define Guppy_step
	if(instance_exists(target) and target_visible) {
		motion_add(direction - (angle_difference(direction, point_direction(x, y, target.x, target.y)) * 0.3), walkspeed);
		enemy_face(direction);
	}
	
	enemy_step();

#define Guppy_alrm1
	alarm1 = 10 + irandom(5);
	
	if(enemy_target(x, y) and target_visible) {
		enemy_walk(direction, alarm1);
	}
	
	else {
		direction = random(360);
		enemy_walk(direction, alarm1);
	}
	
	enemy_face(direction);

#define Guppy_death
	pickup_drop(10, 0);

#define HeavyBandit_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)) {
		 // Visual:
		spr_idle   = spr.HeavyBanditIdle;
		spr_walk   = spr.HeavyBanditWalk;
		spr_hurt   = spr.HeavyBanditHurt;
		spr_dead   = spr.HeavyBanditDead;
		spr_weap   = sprBanditGun;
		spr_shadow = shd24;
		hitid      = [spr_idle, "HEAVY BANDIT"];
		depth      = -2;

		 // Sound:
		snd_hurt = sndMolefishHurt;
		snd_dead = sndMolefishDead;
		
		 // Vars:
		mask_index  = mskBandit;
		maxhealth   = 12;
		raddrop     = 5;
		size        = 1;
		walk	    = 0;
		walkspeed   = 0.8;
		maxspeed    = 3.4;
		gunangle    = random(360);
		direction   = gunangle;
		
		 // Alarms:
		alarm1 = 50 + irandom(20);
		
		return self;
	}

#define HeavyBandit_step
	enemy_step();
	if(alarm2_run) exit;
	
	if(alarm2) {
		if(enemy_target(x, y)) {
			gunangle = target_direction;
			direction = gunangle;
			enemy_face(gunangle);
		}
	}

#define HeavyBandit_alrm1
	alarm1 = 20 + irandom(20);
	
	if(enemy_target(x, y) and target_visible) {
		if(target_distance < 128) {
			if(target_distance > 32 and chance(1, 2)) {
				alarm1 = 30 + irandom(20);
				gunangle = target_direction + orandom(10);
				direction = gunangle;
				
				call(scr.fx, x, y, 0, WepSwap).depth = depth - 1;
				call(scr.fx, x, y, 0, AssassinNotice);
				
				alarm2 = 16 + irandom(8);
				
				sound_play_pitchvol(sndSwapPistol, 1.2 + random(0.2), 0.4);
			}
			
			else {
				alarm1 = 40 + irandom(20);
				gunangle = target_direction + orandom(40);
				enemy_walk(gunangle, alarm1 - 10);
			}
		}
		
		else {
			gunangle = target_direction + orandom(20);
			enemy_walk(gunangle, alarm1 - 10);
		}
	}
	
	else {
		gunangle = random(360);
		enemy_walk(gunangle, alarm1 - 10);
	}
	
	enemy_face(direction);

#define HeavyBandit_alrm2
	repeat(3 + irandom(2)) {
		call(scr.fx, x, y, [gunangle + orandom(10), 2 + random(3)], Smoke)
		sound_play_pitch(sndMolefishFire, 1 + random(0.2));
	}

	if(fork()) {
		repeat(3) {
			if(!instance_exists(self)) exit;
			
			if(enemy_target(x, y)) {
				gunangle = target_direction + orandom(15);
			}
			
			else {
				gunangle += orandom(20);
			}
			
			call(scr.projectile_create, self, x, y, EnemyBullet1, gunangle, 4);
			sound_play_pitch(sndEnemyFire, 1 + random(0.2));
			direction = gunangle;
			motion_add(direction + 180, 1);
			
			wait 2 + irandom(3);
		}
		
		exit;
	}

#define HeavyBandit_draw
	draw_self_gun();

#define HellKnight_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
		 // Visual:
		spr_idle     = spr.KnightIdle;
		spr_walk     = spr.KnightWalk;
		spr_hurt     = spr.KnightHurt;
		spr_dead     = spr.KnightDead;
		spr_shadow   = shd24;
		spr_shadow_y = 5;
		spr_weap     = spr.KnightSword;
		hitid        = [spr_idle, "KNIGHT"];
		depth        = -4;
		sprite_index = spr_idle;
		
		 // Sound:
		snd_hurt = sndJockHurt;
		snd_dead = sndJockDead;
		snd_mele = sndRhinoFreakMelee;
		
		 // Vars:
		mask_index  = mskRhinoFreak;
		maxhealth   = 56;
		canmelee    = false;
		raddrop     = 25; 
		size        = 2;
		walk        = 0;
		walkspeed   = 1;
		maxspeed    = 2.4;
		gunangle    = random(360);
		direction   = gunangle;
		wepangle    = 110 * choose(-1, 1);
		
		 // Alarms:
		alarm1 = 60 + irandom(30);
		
		return self;
	}

#define HellKnight_step
	if(alarm1_run) exit;
	if(alarm2_run) exit;

    enemy_step();
	
	if(wkick > 0) {
		wkick -= current_time_scale;
		if(wkick < 0) wkick = 0;
	}

#define HellKnight_alrm1
	alarm1 = 60 + irandom(30);

	if(enemy_target(x, y) and target_visible) {
		enemy_look(target_direction);
		
		if(target_distance < 128){
			 // Attack:
			if(chance(1, 2) and target_distance < 96){
				alarm1 = 100 + irandom(10);
				alarm2 = 10;
				
				 // Alert:
				call(scr.fx, x, y, 0, AssassinNotice).depth = depth - 1;
				sound_play_pitch(snd_mele, 1.4 + random(0.3))
			}
			
			 // Move Towards Target:
			else{
				alarm1 = 15 + irandom(15);
				enemy_walk(gunangle + orandom(15), alarm1 - 5);
			}
		}
	}
	
	 // Wander:
	else{
		enemy_walk(random(360), 30);
		enemy_look(direction);
	}

#define HellKnight_alrm2
	call(scr.projectile_create, self, x, y, EnemySlash, gunangle, 1).sprite_index = sprHeavySlash;
				
	var offset = 15;
	call(scr.projectile_create, self, x + lengthdir_x(28, gunangle - offset), y + lengthdir_y(28, gunangle - offset), "KnightQuake", gunangle - offset, 4);
	call(scr.projectile_create, self, x + lengthdir_x(28, gunangle), y + lengthdir_y(28, gunangle), "KnightQuake", gunangle, 4);
	call(scr.projectile_create, self, x + lengthdir_x(28, gunangle + offset), y + lengthdir_y(28, gunangle + offset), "KnightQuake", gunangle + offset, 4);
	
	sound_play_pitch(snd_mele, 0.8 + random(0.3));
	sound_play_pitch(sndHammer, 0.7 + random(0.3));
	motion_add(gunangle, 4);
	wepangle *= -1;
	wkick = -7;


#define HellKnight_death
    pickup_drop(80, 10, 2);

#define HellKnight_draw
	if(gunangle <= 180) draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
	draw_self_enemy();
	if(gunangle >  180) draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);

#define HellTorch_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		 // Visual:
		spr_idle     = spr.TorchUnlit;
		spr_hurt     = spr.TorchUnlitHurt;
		spr_dead     = spr.OldTorchDead;
		spr_shadow   = shd24;
		depth        = 0;
		sprite_index = spr_idle;
		image_speed  = 0.4;
		
		 // Sound:
		snd_hurt = sndHitRock;
		snd_dead = sndPillarBreak;
		
		 // Vars:
		mask_index  = mskGuardianIdle;
		maxhealth   = 40;
		my_health   = maxhealth;
		team		= 1;
		
		return self;
	}

#define HellTorch_step
	x = xstart;
	y = ystart;
	speed = 0;
	
	sprite_index = enemy_sprite;
	
	 // Death:
	if(my_health <= 0) instance_destroy();

#define HellTorch_hurt(_hitdmg, _hitvel, _hitdir)
	if(instance_is(other, Flame) or instance_is(other, Explosion)) {
		if(instance_exists(GameCont)) GameCont.killenemies = 1;
		with(GameCont) {
			area = "castle";
			subarea = 0;
		}
		instance_create(x, y, Portal);
		sound_play(sndUncurse);
		my_health = 0;
	}
	
	else {
		my_health -= _hitdmg;          // Damage
		sound_play_hit(snd_hurt, 0.3); // Sound
	
		 // Hurt Sprite:
		sprite_index = spr_hurt;
		image_index = 0;
	}
	
#define HellTorch_destroy
	corpse_drop(self);

#define Imp_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
		 // Visual:
		spr_idle     = spr.ImpIdle;
		spr_walk     = spr_idle;
		spr_hurt     = spr.ImpHurt;
		spr_dead     = spr.ImpDead;
		spr_dash     = spr.ImpDash;
		spr_shadow   = shd24;
		spr_shadow_y = 3;
		spr_weap     = spr.Pitchfork;
		hitid        = [spr_idle, "IMP"];
		depth        = -2;
		sprite_index = spr_idle;
		
		 // Sound:
		snd_hurt = sndComputerBreak;
		snd_dead = sndConfetti5;
		snd_mele = sndBallMamaFire;
		
		 // Vars:
		mask_index  = mskBandit;
		maxhealth   = 30;
		canmelee    = false;
		raddrop     = 14; 
		size        = 1;
		walk        = 0;
		walkspeed   = 0.8;
		maxspeed    = 4;
		friction    = 0.3;
		gunangle    = random(360);
		direction   = gunangle;
		wepangle    = 110 * choose(-1, 1);
		
		 // Alarms:
		alarm1 = 45 + irandom(40);
		
		return self;
	}

#define Imp_step
	 // Alarms:
	if("on_alrm0" in self and alarm0_run) exit;
	if("on_alrm1" in self and alarm1_run) exit;
	
	 // Movement:
	if(walk > 0){
		walk -= current_time_scale;
		speed += walkspeed * current_time_scale;
	}
	if(speed > maxspeed){
		speed = maxspeed;
	}
	
	 // Animate:
	if(sprite_index = spr_dash) {
		if(anim_end) sprite_index = spr_idle;
	}
	else sprite_index = enemy_sprite;

#define Imp_alrm1
	alarm1 = 40 + irandom(30);

	if(enemy_target(x, y) and target_visible) {
		enemy_look(target_direction);
		
		if(target_distance < 128){
			 // Attack:
			if(chance(3, 4) and (target_distance > 64 or target_distance < 32)){
				alarm1 = 40 + irandom(10);
				repeat(3) {
					call(scr.projectile_create, self, x, y, FireBall, gunangle + orandom(8), 3 + random(2));
				}
				
				sound_play_pitch(sndConfettiGun, 1.6 + random(0.3));
				sound_play(sndChickenSword);
				motion_add(gunangle, 4);
				wepangle *= -1;
				wkick = -10;
			}
			
			 // Move Away From Target:
			else{
				alarm1 = 30 + irandom(15);
				enemy_walk(gunangle + 180 + orandom(30), alarm1 - 10);
				sound_play_pitch(sndRavenLift, 1.8 + random(0.3));
				sprite_index = spr_dash;
			}
		}
	}
	
	 // Wander:
	else{
		enemy_walk(random(360), 30);
		enemy_look(direction);
	}

#define Imp_hurt(_hitdmg, _hitvel, _hitdir)
	my_health -= _hitdmg;			// Damage
	motion_add(_hitdir, _hitvel);	// Knockback
	nexthurt = current_frame + 6;	// I-Frames
	call(scr.sound_play_at, x, y, snd_hurt, 1.6 + random(0.3), 1, 64, 1);  // Sound

	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index = 0;

#define Imp_death
    pickup_drop(40, 0, 2);
    
    sound_play_pitchvol(snd_dead, 1.8 + random(0.3), 1.3);
	snd_dead = -1;

#define Imp_draw
	if(gunangle <= 180) draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
	draw_self_enemy();
	if(gunangle >  180) draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);

#define Jelly_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)) {
		 // Visual:
		spr_idle   = spr.JellyIdle;
		spr_walk   = spr_idle;
		spr_hurt   = spr.JellyHurt;
		spr_dead   = spr.JellyDead;
		spr_shadow = shd32;
		spr_shadow_y += 12;
		hitid      = [spr_idle, "JELLY"];
		depth      = -3;

		 // Sound:
		snd_hurt = sndOasisHurt;
		snd_dead = sndOasisDeath;
		
		 // Vars:
		mask_index  = mskBanditBoss;
		maxhealth   = 60;
		raddrop     = 16;
		size        = 0;
		walk	    = 0;
		walkspeed   = 1;
		maxspeed    = 2.5;
		direction   = random(360);
		meleedamage = 4;
		
		 // Alarms:
		alarm1 = 40 + irandom(20);
		
		return self;
	}

#define Jelly_alrm1
	alarm1 = 60 + irandom(10);
	
	if(enemy_target(x, y) and target_visible) {
		direction = target_direction + orandom(40);
		enemy_walk(direction, ceil(alarm1/2));
	}
	
	else {
		direction = random(360);
		enemy_walk(direction, ceil(alarm1/2));
	}
	
	enemy_face(direction);
	
#define Jelly_death
	repeat(3 + irandom(3)) {
		with(call(scr.obj_create, x, y, "Guppy")) motion_add(random(360), 4);
	}
	
	if(chance(1, 2)) call(scr.obj_create, x, y, BoneFish);
	
	call(scr.fx, x, y, 0, ExploderExplo);
	repeat(2) pickup_drop(70, 20, 2);
	
	sound_play_pitch(sndOasisExplosionSmall, 0.6 + random(0.2));

#define KnightQuake_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		 // Visual:
		sprite_index = mskNone;
		image_speed  = 0.4;
		
		 // Vars:
		mask_index = mskDisc;
		damage     = 2;
		force      = 4;
		typ        = 0;
		len 	   = 5;
		
		alarm1 = 5;
		
		return self;
	}

#define KnightQuake_step
	if(alarm1_run) exit;

#define KnightQuake_alrm1
	alarm1 = 5;
	instance_create(x + orandom(6), y + orandom(6), RabbitPaw).sprite_index = sprThrowHit;
	sound_play_pitch(sndGrenadeRifle, 0.5 + random(0.3));
	sound_play_pitch(sndWallBreak, 1.6 + random(0.3))
	
	repeat(irandom_range(1, 3)) {
		with(instance_create(x, y, Debris)) {
			direction = other.direction + 180 + orandom(5);
			speed = random(4);
			mask_index = mskNone;
		}
	}
	len--;
	if(len <= 0) instance_destroy();
	
#define KnightQuake_hit
	if(projectile_canhit_melee(other)){
		projectile_hit_push(other, round(damage * image_xscale), force);
		
		 // Effects:
		var	_sleep = (10 / 3) * floor(sprite_width / 16),
			_shake = 2 + (4 * floor(sprite_get_width(sprite_index) / 32));
		
		if(!instance_is(creator, Player)){
			_sleep *= 3;
			_shake *= 0.5;
		}
		
		sleep(_sleep);
		view_shake_at(x, y, _shake);
	}

#define KnightQuake_destroy
	 // Effects:
	call(scr.fx, x, y, 0, Dust);
	sound_play_hit(sndExplosionS, 0.2);
	
	with(instance_create(x, y, SmallExplosion)) { 
		sprite_index = sprChickenB;
		mask_index = mskWepPickup;
		damage = 0;
	}
	
#define KnightQuake_wall
	instance_destroy();

#define PlasmaEye_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
		 // Visual:
		spr_idle     = spr.EyeIdle;
		spr_walk     = spr_idle;
		spr_hurt     = spr.EyeHurt;
		spr_dead     = spr.EyeDead;
		spr_shadow   = mskNone;
		hitid        = [spr_idle, "EYE"];
		depth        = 0;
		sprite_index = spr_idle;
		
		 // Sound:
		snd_hurt = sndFrogClose;
		snd_dead = sndFrogExplode;
		
		 // Vars:
		mask_index  = mskLilHunter;
		maxhealth   = 14;
		canmelee    = false;
		raddrop     = 5; 
		size        = 1;
		walk        = 0;
		walkspeed   = 0;
		maxspeed    = 0;
		gunangle    = random(360);
		direction   = gunangle;
		right       = 1;
		
		
		 // Alarms:
		alarm1 = 20 + irandom(15);
		
		return self;
	}

#define PlasmaEye_step
	if(alarm1_run) exit;
	if(alarm2_run) exit;

	x = xstart;
	y = ystart;
	speed = 0;

	if(instance_exists(target)) gunangle = target_direction;

	sprite_index = enemy_sprite;

#define PlasmaEye_alrm1
	alarm1 = 40 + irandom(30);

	if(enemy_target(x, y) and target_visible) {
		if(target_distance < 240 and random(4) < 3){
			alarm1 = 80 + irandom(20);
			alarm2 = 15;
			
			call(scr.projectile_create, self, x, y, MeatExplosion);
			
			sound_play_pitch(sndLaserCannonCharge, 0.8 + random(0.3));
			sound_play_pitch(sndFrogEggSpawn1, 0.8 + random(0.3));
		}
	}

#define PlasmaEye_alrm2
	call(scr.projectile_create, self, x, y, "RelicsPlasma", gunangle, 1).damage = 2;
	
	sound_play_pitch(sndPlasma, 1.2 + random(0.3));
	sound_play_pitch(sndBloodLauncher, 0.4 + random(0.3));

#define PlasmaEye_draw
	if(sprite_index = spr_idle and "target" in self and instance_exists(target)) image_index = round(point_direction(x, y, target.x, target.y)/45);
    draw_self_enemy();

#define PlasmaEye_hurt(_hitdmg, _hitvel, _hitdir)
	my_health -= _hitdmg;			// Damage
	nexthurt = current_frame + 6;	// I-Frames
	call(scr.sound_play_at, x, y, snd_hurt, 1 + random(0.3), 1, 64, 1);  // Sound

	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index = 0;

#define PlasmaEye_death
	pickup_drop(40, 10, 1);

#define SmallDog_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)) {
		 // Visual:
		spr_idle   = spr.SmallDogIdle;
		spr_walk   = spr.SmallDogWalk;
		spr_hurt   = spr.SmallDogHurt;
		spr_dead   = spr.SmallDogDead;
		spr_shadow = shd24;
		//spr_shadow_y += 12;
		hitid      = [spr_idle, "SMALL DOG"];
		depth      = -2;

		 // Sound:
		snd_hurt = sndWolfHurt;
		snd_dead = sndWolfDead;
		
		 // Vars:
		mask_index  = mskSnowBot;
		maxhealth   = 40;
		raddrop     = 14;
		size        = 1;
		walk	    = 0;
		walkspeed   = 1;
		maxspeed    = 3;
		direction   = random(360);
		meleedamage = 3;
		
		 // Alarms:
		alarm1 = 40 + irandom(40);
		
		return self;
	}

#define SmallDog_alrm1
	alarm1 = 60 + irandom(10);
	
	if(enemy_target(x, y) and target_visible) {
		alarm1 = 40 + irandom(20);
		direction = target_direction + orandom(20);
		enemy_walk(direction, alarm1 - 10);
		if(chance(1, 6)) {
			with(instance_create(x, y, ScrapBossMissile)) {
				motion_add(other.direction, other.speed);
			}
			sound_play_pitch(sndBigDogMissile, 1.2 + random(0.2));
		}
	}
	
	else if(chance(1, 3)) {
		direction = random(360);
		enemy_walk(direction, alarm1 - 20);
	}
	
	enemy_face(direction);
	
#define SmallDog_death
	pickup_drop(60, 10, 2);
	with(instance_create(x, y, ScrapBossMissile)) {
		motion_add(other.direction, other.speed);
	}
	sound_play_pitch(sndBigDogMissile, 1.2 + random(0.2));

#define SodaBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		 // Visual:
		spr_idle     = sprSodaCan;
		sprite_index = spr_idle;
		image_speed  = 0;
		image_index  = irandom(2);
		image_angle  = random(360);
		
		 // Vars:
		mask_index = mskEnemyBullet1;
		friction   = 0.2;
		damage     = 2;
		force      = 4;
		typ        = 2;
		
		return self;
	}
	
#define SodaBullet_step
	image_angle += speed;

	 // Disappear:
	if(speed = 0) {
		instance_destroy();
	}
	
#define SodaBullet_anim
	if(instance_exists(self)){
		if(sprite_index == spr_spwn){
			image_speed = 0.4;
			sprite_index = spr_idle;
		}
		
		 // Goodbye:
		else if(sprite_index == spr_fade){
			instance_destroy();
		}
	}
	
#define SodaBullet_hit
	if(projectile_canhit_melee(other)){
		projectile_hit_np(other, damage, force, 10);
		
		instance_destroy();
	}
	
#define SodaBullet_wall
	instance_create(x, y, Dust);
	sound_play_hit(sndHitWall, 0.2);
	instance_destroy();
	
#define SodaBullet_destroy
	with(instance_create(x, y, Shell)) {
		motion_add(other.direction, other.speed);
		sprite_index = other.spr_idle;
		image_speed  = 0;
		image_index  = other.image_index;
		image_angle  = other.image_angle;
	}

#define SodaMimic_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)) {
		 // Visual:
		spr_idle   = spr.SodaMimicIdle;
		spr_walk   = spr.SodaMimicWalk;
		spr_hurt   = spr.SodaMimicHurt;
		spr_dead   = spr.SodaMimicDead;
		spr_tell   = spr.SodaMimicTell;
		spr_shadow = shd32;
		spr_shadow_y = 5;
		hitid      = [spr_tell, "SODA MIMIC"];
		depth      = -2;

		 // Sound:
		snd_hurt = sndMimicHurt;
		snd_dead = sndMimicDead;
		
		 // Vars:
		mask_index  = spr_idle;
		maxhealth   = 20;
		raddrop     = 10;
		size        = 0;
		walk	    = 0;
		walkspeed   = 0.8;
		maxspeed    = 2;
		friction    = 0.4;
		direction   = random(360);
		meleedamage = 5;
		
		 // Alarms:
		alarm1 = 30 + irandom(15);
		
		return self;
	}

#define SodaMimic_step
	 // Alarms:
	if("on_alrm0" in self and alarm0_run) exit;
	if("on_alrm1" in self and alarm1_run) exit;
	
	 // Movement:
	if(walk > 0){
		walk -= current_time_scale;
		speed += walkspeed * current_time_scale;
	}
	if(speed > maxspeed){
		speed = maxspeed;
	}
	
	 // Animate:
	if(sprite_index = spr_tell) {
		if(anim_end) sprite_index = spr_idle;
	}
	else sprite_index = enemy_sprite;

#define SodaMimic_alrm1
	alarm1 = 30 + irandom(10);
	
	if(enemy_target(x, y) and target_visible and target_distance < 64) {
		enemy_walk(target_direction, alarm1);
		enemy_face(target_direction);
		
		sound_play_pitch(sndMimicMelee, 1.2 + random(0.3));
		sound_play_pitch(choose(sndCanBounce1, sndCanBounce2), 1 + random(0.4));
		
		if(chance(2, 3)) {
			sound_play_pitch(sndShotgun, 1.6 + random(0.2));
			sound_play_pitch(sndSodaMachineBreak, 1 + random(0.2));
			
			repeat(4) call(scr.projectile_create, self, x, y, "SodaBullet", target_direction + orandom(20), 5 + random(4));
		}
	}
	
	else {
		if(sprite_index = spr_idle and chance(1, 8)) {
			sprite_index = spr_tell;
			image_index = 0;
			sound_play_pitch(sndMimicSlurp, 1.1 + random(0.2));
			
			if(fork()) {
				repeat(7 + irandom(3)) {
					sound_play_pitch(choose(sndCanBounce1, sndCanBounce2), 1 + random(0.4));
					wait 1 + irandom(2);
				}
				exit;
			}
		}
	}

#define SodaMimic_death
	pickup_drop(100, 60, 2);
	
#define ShieldSpider_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)) {
		 // Visual:
		spr_idle   = spr.ShieldSpiderIdle;
		spr_walk   = spr.ShieldSpiderWalk;
		spr_hurt   = spr.ShieldSpiderHurt;
		spr_dead   = spr.ShieldSpiderDead;
		spr_shld   = spr.ShieldSpiderShield;
		spr_shadow = shd32;
		spr_shadow_y = 5;
		hitid      = [spr_idle, "SHIELD SPIDER"];
		depth      = -2;

		 // Sound:
		snd_hurt = sndMimicHurt;
		snd_dead = sndMimicDead;
		
		 // Vars:
		mask_index  = mskSpider;
		maxhealth   = 44;
		raddrop     = 22;
		size        = 1;
		walk	    = 0;
		walkspeed   = 0.8;
		maxspeed    = 2.8;
		direction   = random(360);
		meleedamage = 3;
		shielding   = false;
		
		 // Alarms:
		alarm1 = 40 + irandom(15);
		
		return self;
	}

#define ShieldSpider_step
	 // Alarms:
	if("on_alrm0" in self and alarm0_run) exit;
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;
	
	 // Movement:
	if(walk > 0){
		walk -= current_time_scale;
		speed += walkspeed * current_time_scale;
	}
	if(speed > maxspeed){
		speed = maxspeed;
	}
	
	 // Animate:
	if(sprite_index = spr_shld) {
		if(anim_end) {
			if(spr_shld = spr.ShieldSpiderShield) {
				spr_idle = spr.ShieldSpiderShielded;
				spr_hurt = spr.ShieldSpiderShieldedHurt;
				spr_shld = spr.ShieldSpiderOff;
				shielding = true;
			}
			
			else {
				spr_idle = spr.ShieldSpiderIdle;
				spr_hurt = spr.ShieldSpiderHurt;
				spr_shld = spr.ShieldSpiderShield;
			}
			
			sprite_index = spr_idle;
		}
	}
	else sprite_index = enemy_sprite;

#define ShieldSpider_hurt(_damage, _force, _direction)
	if(shielding) {
		call(scr.projectile_create, self, x, y, EnemyBullet1, _direction + 180 + orandom(25), min(_force, 4));
		sound_play_hit(sndShielderDeflect, 0.5);
		sound_play_hit(sndCrystalPropBreak, 0.5);
	}
	
	else {
		my_health -= _damage;           // Damage
		motion_add(_direction, _force); // Knockback
		sound_play_hit(snd_hurt, 0.2);  // Sound
	}
	
	nexthurt = current_frame + 6;   // I-Frames
	
	if((!shielding and spr_shld = spr.ShieldSpiderShield) or sprite_index != spr_shld) {
		if(sprite_index = spr_shld) {
			call(scr.fx, x, y, 0, AssassinNotice).depth = depth - 1;
			sound_play_pitch(sndWallBreakCrystal, 1.6 + random(0.2));
			sound_play_pitch(sndCrystalShield, 1.6 + random(0.2));
			alarm2 = -1;
		}
		
		 // Hurt Sprite:
		sprite_index = spr_hurt;
		image_index  = 0;
	}

#define ShieldSpider_alrm1
	alarm1 = 30 + irandom(10);
	
	if(sprite_index != spr_shld) {
		if(enemy_target(x, y) and target_visible and target_distance < 128) {
			if(chance(1, 3)) {
				alarm1 = 120 + irandom(20);
				alarm2 = alarm1 - 20;
				
				spr_shld = spr.ShieldSpiderShield;
				sprite_index = spr_shld;
				
				sound_play_pitch(sndCrystalRicochet, 0.8 + random(0.2));
				sound_play_pitch(sndCrystalPropBreak, 1.2 + random(0.2));
				
			}
			
			else {
				enemy_walk(target_direction, alarm1 - 15);
			}
		}
		
		else {
			enemy_walk(random(360), alarm1 - 5);
		}
	}
	
	enemy_face(direction);

#define ShieldSpider_alrm2
	sprite_index = spr_shld;
	shielding	 = false;

#define ShieldSpider_death
	repeat(2) pickup_drop(70, 10, 2);

#macro  spr                                                                                     global.spr
#macro  snd                                                                                     global.snd
#macro  msk                                                                                     spr.msk
#macro  scr																						global.scr
#macro  call																					script_ref_call
#macro	variant_areas																			global.area_variants
#macro  type_melee                                                                              0
#macro  type_bullet                                                                             1
#macro  type_shell                                                                              2
#macro  type_bolt                                                                               3
#macro  type_explosive                                                                          4
#macro  type_energy                                                                             5
#macro  area_campfire                                                                           0
#macro  area_desert                                                                             1
#macro  area_sewers                                                                             2
#macro  area_scrapyards                                                                         3
#macro  area_caves                                                                              4
#macro  area_city                                                                               5
#macro  area_labs                                                                               6
#macro  area_palace                                                                             7
#macro  area_vault                                                                              100
#macro  area_oasis                                                                              101
#macro  area_pizza_sewers                                                                       102
#macro  area_mansion                                                                            103
#macro  area_cursed_caves                                                                       104
#macro  area_jungle                                                                             105
#macro  area_hq                                                                                 106
#macro  area_crib                                                                               107
#macro  infinity                                                                                1/0
#macro  anim_end                                                                                (image_index + image_speed >= image_number) || (image_index + image_speed < 0)
#macro  enemy_sprite                                                                            (sprite_index != spr_hurt || anim_end) ? ((speed == 0) ? spr_idle : spr_walk) : sprite_index
#macro  target_visible                                                                          !collision_line(x, y, target.x, target.y, Wall, false, false)
#macro  target_direction                                                                        point_direction(x, y, target.x, target.y)
#macro  target_distance                                                                         point_distance(x, y, target.x, target.y)
#macro  alarm0_run                                                                              alarm0 && !--alarm0 && !--alarm0 && (script_ref_call(on_alrm0) || !instance_exists(self))
#macro  alarm1_run                                                                              alarm1 && !--alarm1 && !--alarm1 && (script_ref_call(on_alrm1) || !instance_exists(self))
#macro  alarm2_run                                                                              alarm2 && !--alarm2 && !--alarm2 && (script_ref_call(on_alrm2) || !instance_exists(self))
#macro  alarm3_run                                                                              alarm3 && !--alarm3 && !--alarm3 && (script_ref_call(on_alrm3) || !instance_exists(self))
#macro  alarm4_run                                                                              alarm4 && !--alarm4 && !--alarm4 && (script_ref_call(on_alrm4) || !instance_exists(self))
#macro  alarm5_run                                                                              alarm5 && !--alarm5 && !--alarm5 && (script_ref_call(on_alrm5) || !instance_exists(self))
#macro  alarm6_run                                                                              alarm6 && !--alarm6 && !--alarm6 && (script_ref_call(on_alrm6) || !instance_exists(self))
#macro  alarm7_run                                                                              alarm7 && !--alarm7 && !--alarm7 && (script_ref_call(on_alrm7) || !instance_exists(self))
#macro  alarm8_run                                                                              alarm8 && !--alarm8 && !--alarm8 && (script_ref_call(on_alrm8) || !instance_exists(self))
#macro  alarm9_run                                                                              alarm9 && !--alarm9 && !--alarm9 && (script_ref_call(on_alrm9) || !instance_exists(self))
#define chance(_numer, _denom)                                                          		return  random(_denom) < _numer;
#define chance_ct(_numer, _denom)                                                       		return  random(_denom) < _numer * current_time_scale;
#define orandom(_num)                                                                   		return  random_range(-_num, _num);
#define draw_self_enemy()                                                                       image_xscale *= right; draw_self(); image_xscale /= right;
#define draw_self_gun()																			if(gunangle <= 180) draw_weapon(spr_weap, 0, x, y, gunangle, 0, wkick, right, image_blend, image_alpha); draw_self_enemy(); if(gunangle > 180) draw_weapon(spr_weap, 0, x, y, gunangle, 0, wkick, right, image_blend, image_alpha);
#define enemy_walk(_dir, _num)                                                                  direction = _dir; walk = _num; if(speed < friction) speed = friction;
#define enemy_face(_dir)                                                                        _dir = ((_dir % 360) + 360) % 360; if(_dir < 90 || _dir > 270) right = 1; else if(_dir > 90 && _dir < 270) right = -1;
#define enemy_look(_dir)                                                                        _dir = ((_dir % 360) + 360) % 360; if(_dir < 90 || _dir > 270) right = 1; else if(_dir > 90 && _dir < 270) right = -1; if('gunangle' in self) gunangle = _dir;
#define enemy_target(_x, _y)                                                                    target = (instance_exists(Player) ? instance_nearest(_x, _y, Player) : ((instance_exists(target) && target >= 0) ? target : noone)); return (target != noone);
#define enemy_step
	 // Alarms:
	if("on_alrm0" in self and alarm0_run) exit;
	if("on_alrm1" in self and alarm1_run) exit;
	
	 // Movement:
	if(walk > 0){
		walk -= current_time_scale;
		speed += walkspeed * current_time_scale;
	}
	if(speed > maxspeed){
		speed = maxspeed;
	}
	
	 // Animate:
	sprite_index = enemy_sprite;
	
	
#define enemy_hurt(_damage, _force, _direction)
	my_health -= _damage;           // Damage
	nexthurt = current_frame + 6;   // I-Frames
	motion_add(_direction, _force); // Knockback
	sound_play_hit(snd_hurt, 0.2);  // Sound
	
	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index  = 0;
	
#define enemy_death
	pickup_drop(20, 0);

#define area_variant_add(_chance, _area, _name, _tips, _enter, _step, _leave)
	/*
		Adds an area variant to the pool of possible variants
		
		Args:
			chance - Chance of occuring, integer
			area   - Area the variant occurs in, integer or string for modded areas
			name   - Name of the variant, string
			tips   - The selection of tips for the given variant, array of strings
			enter  - Script run when the level is finished generating, use this to set sprites, add/replace/remove enemies and props, or add new levelgen, script reference. Return -1 if there is no enter script
			step   - Script run while the variant is active, script reference. Return -1 if there is no step script
			leave  - Script run when the variant is left, use this to reset any drastic changes that won't return to normal from proceeding to the next area, script reference. Return -1 if there is no leave script
	*/
	
	array_push(variant_areas, {
		variant_chnc : _chance,
		variant_area : _area,
		variant_name : _name,
		variant_tips : _tips,
		variant_entr : _enter,
		variant_step : _step,
		variant_leav : _leave
	});
	
#define corpse_drop // inst, direction=inst.direction, speed=inst.speed
	/*
		Creates a corpse based on the given hitme's variables
		
		Args:
			inst      - The hitme whose corpse will be dropped
			direction - The corpse's direction, defaults to the hitme's direction
			speed     - The corpse's base speed, defaults to the hitme's speed
	*/
	
	with(argument[0]){
		with(instance_create(x, y, Corpse)){
			size         = other.size;
			sprite_index = other.spr_dead;
			image_xscale = (("right" in other) ? other.right : other.image_xscale);
			direction    = ((argument_count > 1) ? argument[1] : other.direction);
			speed        = ((argument_count > 2) ? argument[2] : other.speed);
			
			 // Non-Props:
			if(!instance_is(other, prop) && instance_is(other, hitme)){
				mask_index = other.mask_index;
				speed += max(0, -other.my_health / 5);
				speed += 8 * skill_get(mut_impact_wrists) * instance_is(other, enemy);
			}
			
			 // Clamp Speed:
			speed = min(speed, 16);
			if(size > 0){
				speed /= size;
			}
			
			return self;
		}
	}
	
	return noone;

#define draw_lasersight // x, y, dir, disMax=1000, width=1
	/*
		Performs hitscan and draws a laser sight line
		Returns the line's ending position
		
		Args:
			x/y    - The laser's starting position
			dir    - The laser's hitscan direction
			disMax - How far the laser can travel, defaults to 1000
			width  - The laser's width, defaults to 1
	*/
	
	var	_x      = argument[0],
		_y      = argument[1],
		_dir    = argument[2],
		_disMax = ((argument_count > 3) ? argument[3] : 1000),
		_width  = ((argument_count > 4) ? argument[4] : 1),
		_dis    = _disMax,
		_disX   =  dcos(_dir),
		_disY   = -dsin(_dir),
		_endX   = _x + (_dis * _disX),
		_endY   = _y + (_dis * _disY);
		
	 // Context Fix:
	if(!is_real(self) || !instance_exists(self)){
		with(UberCont){
			return draw_lasersight(_x, _y, _dir, _disMax, _width);
		}
	}
	
	 // Binary Collision Line Search:
	var _wall = collision_line(_x, _y, _endX, _endY, Wall, false, false);
	if(_wall){
		while(_dis >= 1){
			_dis /= 2;
			if(_wall){
				_endX -= _dis * _disX;
				_endY -= _dis * _disY;
			}
			else{
				_endX += _dis * _disX;
				_endY += _dis * _disY;
			}
			_wall = collision_line(_x, _y, _endX, _endY, Wall, false, false);
		}
	}
	
	 // Draw:
	draw_line_width(_x - 1, _y - 1, _endX - 1, _endY - 1, _width);
	
	return [_endX, _endY];

#define draw_weapon(_sprite, _image, _x, _y, _angle, _angleMelee, _kick, _flip, _blend, _alpha)
	/*
		Drawing weapon sprites
		
		Ex:
			draw_weapon(sprBanditGun, gunshine, x, y, gunangle, 0, wkick, right, image_blend, image_alpha)
			draw_weapon(sprPipe, 0, x, y, gunangle, wepangle, wkick, wepflip, image_blend, image_alpha)
	*/
	
	 // Context Fix:
	if(!is_real(self) || !instance_exists(self)){
		with(UberCont){
			return draw_weapon(_sprite, _image, _x, _y, _angle, _angleMelee, _kick, _flip, _blend, _alpha);
		}
	}
	
	 // Melee Offset:
	if(_angleMelee != 0){
		_angle += _angleMelee * (1 - (_kick / 20));
	}
	
	 // Kick:
	if(_kick != 0){
		_x -= lengthdir_x(_kick, _angle);
		_y -= lengthdir_y(_kick, _angle);
	}
	
	 // Draw:
	draw_sprite_ext(_sprite, _image, _x, _y, 1, _flip, _angle, _blend, _alpha);

#define floor_fill(_x, _y, w, h)
	for(ix = 0; ix < abs(w); ix++) {
		for(iy = 0; iy < abs(h); iy++) {
			instance_create(grid_lock(_x, 32) + (ix * (32 * sign(w))) + 16, grid_lock(_y, 32) + (iy * (32 * sign(h))) + 16, Floor);
		}
	}

#define grid_lock(value, grid)
	return floor(value/grid) * grid; // Returns the given value locked to the given grid size

#define hitme_step
	if(place_meeting(x + hspeed, y + vspeed, Wall)) move_bounce_solid(true);
	
	 // Handle enemies:
	with(call(scr.instances_meeting, x, y, enemy)){
		if(projectile_canhit_melee(other) && "canmelee" in self && canmelee && meleedamage > 0){
			projectile_hit(other, meleedamage);
		}
		
		with(other){
			if(projectile_canhit_melee(other)){
				projectile_hit(other, 3);
				sound_play_pitch(sndFreakMelee, 1.2 + random(0.4));
			}
		}
	}