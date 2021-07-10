#define init
	spr = mod_variable_get("mod", "relics", "spr");
	
#define area_subarea           return 3;
#define area_goal              return 110;
#define area_next     
	return [area_palace, 3];
#define area_background_color  return make_color_rgb(69, 80, 95);
#define area_shadow_color      return c_black;
#define area_darkness          return false;
#define area_secret            return false;

#define area_name(_subarea, _loops)
	return `@1(${spr.CastleIcon})7-${_subarea}`;
	
#define area_text
	return choose(
		"WHERE ARE THE DRAGONS?",
		"THE SMELL OF SULFUR",
		"UNHOLY", 
		"CREATURES OF THE NIGHT",
		"THE EYES WATCH YOU"
	);
	
#define area_mapdata(_lastX, _lastY, _lastArea, _lastSubarea, _subarea, _loops)
	return [
		_lastX,
		9,
		true,
		true
	];
	
#define area_sprite(_spr)
	switch(_spr){
		 // Floors:
		case sprFloor1      : with([self, other]) if(instance_is(self, Floor)){ area_setup_floor(); break; } return spr.CastleFloor;
		case sprFloor1B     : with([self, other]) if(instance_is(self, Floor)){ area_setup_floor(); break; } return spr.CastleFloorB;
		case sprFloor1Explo : return spr.CastleFloorExplo;
		case sprDetail1     : return spr.CastleDetail;
		
		 // Walls:
		case sprWall1Bot    : return spr.CastleWallBot;
		case sprWall1Top    : return spr.CastleWallTop;
		case sprWall1Out    : return spr.CastleWallOut;
		case sprWall1Trans  : return spr.CastleWallTrans;
		case sprDebris1     : return spr.CastleDebris;
		
		 // Decals:
		case sprTopPot      : return spr.CastleTopDecal;
		case sprBones       : return spr.CastleDecal;
	}
	
#define area_setup
	goal             = area_goal();
	background_color = area_background_color();
	BackCont.shadcol = area_shadow_color();
	TopCont.darkness = area_darkness();
	
	sound_play_music(-1);
	sound_play_music(mus7b);
	sound_play_ambient(-1);
	sound_play_ambient(amb7);
	
#define area_setup_floor
	 // Fix Depth:
	if(styleb) depth = 8;
	
	 // Footsteps:
	material = (styleb ? 4 : 1);
	
#define area_finish
	 // Next Subarea:
	if(subarea < area_subarea()){
		subarea++;
	}
	
	 // Next Area:
	else{
		var _next = area_next();
		area    = _next[0];
		subarea = _next[1];
	}
	

#define area_make_floor
	var	_x = x,
		_y = y,
		_outOfSpawn = (point_distance(_x, _y, 10000, 10000) > 48);
		
	/// Make Floors:
		if(random(20) < 1){
			
			 // Special - Cool Square Shapes:
			if(random(4) < 1) {
				
				floor_fill(_x - 64, _y - 64, 5, 1);
				floor_fill(_x - 64, _y     , 5, 1);
				floor_fill(_x - 64, _y + 64, 5, 1);
				
				floor_fill(_x - 64, _y - 64, 1, 5);
				floor_fill(_x     , _y - 64, 1, 5);
				floor_fill(_x + 64, _y - 64, 1, 5);
			}
			
			 // Special - Cool Choke Point Shapes:
			else {
				if(random(2) < 1) {
					floor_fill(_x - 64, _y - 32, 2, 3);
					instance_create(_x, _y, Floor);
					floor_fill(_x + 32, _y - 32, 2, 3);
				}
				
				else {
					floor_fill(_x - 32, _y - 64, 3, 2);
					instance_create(_x, _y, Floor);
					floor_fill(_x - 32, _y + 32, 3, 2);
				}
			}
		}
		
		 // Normal:
		else instance_create(_x, _y, Floor);
		
	/// Turn:
		var _trn = 0;
		if(random(16) < 1){
			_trn = choose(90, 90, -90, -90, 180);
		}
		direction += _trn;
		
	/// Chests & Branching:
		 // Weapon Chests:
		if(_outOfSpawn && _trn == 180){
			instance_create(_x + 16, _y + 16, WeaponChest);
		}
		
		 // Ammo Chests + End Branch:
		var n = instance_number(FloorMaker);
		if(random(19 + n) > 50){
			if(_outOfSpawn){
				instance_create(_x + 16, _y + 16, AmmoChest);
			}
			instance_destroy();
		}
		
		 // Branch:
		if(random(4) < 1){
			instance_create(_x, _y, FloorMaker);
		}
	
#define area_pop_enemies
	var	_x = x + 16,
		_y = y + 16,
		_e = "Imp";
	
	if(random(4) < 1) _e = choose("PlasmaEye", "HellKnight");
	if(styleb and random(4) < 1) _e = "HellKnight";
	if(random(8) < 1) call(scr.obj_create, _x, _y, _e);
	
#define area_pop_props
	var	_x = x + 16,
		_y = y + 16,
		_spawnDis = point_distance(_x, _y, 10016, 10016);
	
	if(_spawnDis > 48 && random(12) < 1){
		with(instance_create(_x, _y, Torch)) {
			spr_idle = spr.OldTorch;
			spr_hurt = spr.OldTorchHurt;
			spr_dead = spr.OldTorchDead;
			
			spr_shad = shd24;
		}
	}
	
#define area_pop_extras
	with(chestprop){
		instance_create(x, y, Bandit);
	}

#macro  spr global.spr
#macro  msk spr.msk
#macro  scr																						mod_variable_get("mod", "relics", "scr")
#macro  call																					script_ref_call
#macro  area_campfire     0
#macro  area_desert       1
#macro  area_sewers       2
#macro  area_scrapyards   3
#macro  area_caves        4
#macro  area_city         5
#macro  area_labs         6
#macro  area_palace       7
#macro  area_vault        100
#macro  area_oasis        101
#macro  area_pizza_sewers 102
#macro  area_mansion      103
#macro  area_cursed_caves 104
#macro  area_jungle       105
#macro  area_hq           106
#macro  area_crib         107

#define floor_fill(_x, _y, w, h)                                            	return mod_script_call_nc('mod', 'relics', 'floor_fill', _x, _y, w, h);