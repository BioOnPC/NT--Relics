#define init
	global.sprIdle   = sprite_add("../sprites/Characters/Turret/sprTurretIdle.png", 6, 12, 12);
	global.sprWalk   = sprite_add("../sprites/Characters/Turret/sprTurretWalk.png", 6, 12 , 12);
	global.sprHurt   = sprite_add("../sprites/Characters/Turret/sprTurretHurt.png", 3, 12, 12);
	global.sprDead   = sprite_add("../sprites/Characters/Turret/sprTurretDead.png", 12, 12 , 12);
	global.sprPort   = sprite_add("../sprites/Characters/Turret/sprTurretPortrait.png", 1, 20, 230);
	global.sprSelect = sprite_add("../sprites/Characters/Turret/sprTurretSelect.png", 1, 0, 0);
	global.sprMap    = sprite_add("../sprites/Characters/Turret/sprTurretMap.png", 1, 10, 10);
	
	 // Reapply sprites if the mod is reloaded. we should add this to our older race mods //
	with(instances_matching(Player, "race", mod_current)) { 
		assign_sprites();
		assign_sounds();
	}
	
	with(instances_matching(CustomHitme, "name", "WepTurret")) { 
		assign_sprites();
	}
	
#define race_name
	return "TURRET";

#define race_text
	return "GENERATES FREE @yAMMO@w#CAN CREATE @yTURRETS@s";

#define race_tb_text
	return "@dNYI@s";

#define race_portrait
	return global.sprPort;

#define race_menu_button
	sprite_index = global.sprSelect;

#define race_soundbank
	return 8;

#define race_ultra_name
	switch(argument0){
		case 1: return "ULTRA A";
		case 2: return "ULTRA B";
		case 3: if(mod_exists("mod", "metamorphosis")) return "ULTRA C";
		case 4: if(mod_exists("mod", "LOMutsSprites")) return "ULTRA D";
	}

#define race_ultra_text 
	switch (argument0){
		case 1: return "@dNYI@s";
		case 2: return "#@dNYI@s";
		case 3: if(mod_exists("mod", "metamorphosis")) return "#@dNYI@s";
		case 4: if(mod_exists("mod", "LOMutsSprites")) return "@dNYI@s";
	}
	
#define race_mapicon
	return global.sprMap;

#define race_ttip
	if(instance_exists(GameCont)) {
		 // SPECIAL //
		if(GameCont.area = 6 and random(3) < 2) return choose("WELCOME HOME", "THEY'VE MISSED YOU"); 
		 // ULTRA TIPS //
		if(GameCont.level >= 10 and random(5) < 1) return choose("GAMMA RAYS", "ALL-KNOWING", "CIRCUITRY OVERLOADING", "OVERFLOWING DATABASES");
	}
	
	 // NORMAL TIPS //
	return choose("ADVANCED", "LOGISTICS", "LATEST MODEL", "DISCOVER IT ALL", "WHAT'S OUT THERE");

#define create
	assign_sprites();
	assign_sounds();
	
	if(instance_is(self, Player)) {
		footkind = 4; // cool footstep sounds
	}

#define step
	var _typ = weapon_get_type(wep),
		_btyp = weapon_get_type(bwep);
	if(ammo[_typ] < typ_amax[_typ] or ammo[_btyp] < typ_amax[_btyp]) {
		if(current_frame mod 60 = 0) {
			var a_increased = 0,
				_amt = min(typ_amax[_typ] - ammo[_typ], ceil(typ_ammo[_typ] * 0.25)),
				_name = typ_name[_typ];
			
			if(_typ and _amt) {
				ammo[_typ] += _amt;
				a_increased++;
			}
			
			_amt = min(typ_amax[_btyp] - ammo[_btyp], ceil(typ_ammo[_btyp] * 0.25));
			_name = typ_name[_btyp];
			
			if(_btyp and _amt) {
				ammo[_btyp] += _amt;
				a_increased++;
			}
			
			
			if(a_increased) {
				sound_play_pitchvol(sndSwapEnergy, 1.2 + random(0.3), 0.3);
				sound_play_pitchvol(sndAmmoChest, 1 + random(0.3), 0.3);
				sound_play_pitchvol(sndClusterOpen, 1 + random(0.3), 0.3);
				instance_create(x, y, BulletHit);
				gunshine = 7;
			}
		}
	}
	
	if(canspec) {
		if(button_pressed(index, "spec") or usespec) {
			if(ammo[weapon_get_type(wep)] >= weapon_get_cost(wep) and weapon_get_type(wep) and !weapon_is_melee(wep)) { 
				var _ammo = min(ammo[weapon_get_type(wep)], typ_ammo[weapon_get_type(wep)] * 3);
				
				ammo[weapon_get_type(wep)] -= _ammo;
				
				with(instance_create(x, y, PopupText)) {
					text = `-${_ammo} ${other.typ_name[weapon_get_type(other.wep)]}`
				}
				
				call(scr.player_swap, self);
				with(call(scr.obj_create, x + lengthdir_x(sprite_width * 0.75, gunangle), y + lengthdir_y(sprite_height * 0.75, gunangle), "WepTurret")) {
					sprite_index = spr_spwn;
					wep = other.bwep;
					ammo = _ammo;
					maxammo = ammo;
					if(other.bcurse) {
						curse = other.bcurse;
						team  = 0;
						sound_play_pitch(sndSwapCursed, 0.6 + random(0.2));
						sound_play_pitch(sndCrownCurses, 0.6 + random(0.2));
					}
					
					else {
						creator = other;
						call(scr.prompt_create, "DESTROY");
					}
				}
				
				sound_play_pitch(sndTurretSpawn, 1.4 + random(0.2));
				sound_play_pitch(sndSwapShotgun, 1.6 + random(0.2));
				sound_play_pitch(sndVanHurt, 1.2 + random(0.2));
				sound_play_pitch(snd_plce, 1 + random(0.3));
				
				bwep = wep_none;
				bcurse = 0;
			}
			
			else {
				if(ammo[weapon_get_type(wep)] < weapon_get_cost(wep)) {
					with(instance_create(x, y, PopupText)) {
						text = `NOT ENOUGH ${other.typ_name[weapon_get_type(other.wep)]}`
					}
				}
				
				if(curse) {
					sound_play_pitch(sndCursedReminder, 1 + random(0.3));
				}
				
				sound_play_pitch(sndTurretHurt, 1.2 + random(0.2));
				weapon_post(-3, 0, 0);
			}
		}
	}

#define assign_sprites
	if(object_index = Player) {
		spr_idle = global.sprIdle//[bskin];
		spr_walk = global.sprWalk//[bskin];
		spr_hurt = global.sprHurt//[bskin];
		spr_dead = global.sprDead//[bskin];
		//spr_sit2 = global.sprSit[bskin];
		//spr_sit1 = global.sprGoSit[bskin];
	}
	
	else if("name" in self and name = "WepTurret") {
		spr_spwn     = spr.SentryPlce;
		spr_idle     = spr.SentryIdle;
		spr_walk     = spr_idle;
		spr_hurt     = spr.SentryHurt;
		spr_dead     = spr.SentryDead;
		spr_fire     = spr.SentryFire;
	}

#define assign_sounds
	snd_hurt = snd.TurretHurt;
	snd_dead = snd.TurretDead;
	snd_lowa = snd.TurretLowA;
	snd_lowh = snd.TurretLowH;
	snd_wrld = snd.TurretWrld;
	snd_crwn = snd.TurretValt;
	snd_chst = snd.TurretChst;
	snd_valt = snd.TurretValt;
	snd_thrn = snd.TurretValt;
	snd_spch = snd.TurretSpch;
	snd_idpd = snd.TurretIDPD;
	snd_cptn = snd.TurretCptn;
	snd_plce = snd.TurretPlce;

#macro  scr																						mod_variable_get("mod", "relics", "scr")
#macro  spr																						mod_variable_get("mod", "relics", "spr")
#macro  snd																						mod_variable_get("mod", "relics", "snd")
#macro  call																					script_ref_call
#define orandom(_num)
	return mod_script_call("mod", "relics", "orandom", _num);

