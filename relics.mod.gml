#define init
	global.obj_list = ["AnglerFish", "EliteSniperDeath", "EliteSniper", "Guppy", "HeavyBandit", "Jelly"];

	global.spr = {};
	
	with(spr) {
		var _p = "sprites/",
			_s = "";
		
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
			//#endregion
			
			//#region DROWNED CITY
				 // Anglerfish
				AnglerFishIdle = sprite_add(_s + "AnglerFish/sprAnglerFishIdle.png", 4, 12, 12);
				AnglerFishWalk = sprite_add(_s + "AnglerFish/sprAnglerFishWalk.png", 4, 12, 12);
				AnglerFishHurt = sprite_add(_s + "AnglerFish/sprAnglerFishHurt.png", 3, 12, 12);
				AnglerFishDead = sprite_add(_s + "AnglerFish/sprAnglerFishDead.png", 6, 12, 12);
			
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

#define obj_create(_x, _y, _name)
     // Vanilla Objects:
	if(is_real(_name) && object_exists(_name)){
		return instance_create(_x, _y, _name);
	}
	
	var o = noone;
	
	if(mod_script_exists("mod", mod_current, string(_name) + "_create")) o = mod_script_call("mod", mod_current, string(_name) + "_create", _x, _y);

     // Instance Stuff:
	if(instance_exists(o)) with(o){
		name = _name;
	
		 // Auto Script Binding:
		with([
			
			 // General:
			"_begin_step",
			"_step",
			"_end_step",
			"_draw",
			"_destroy",
			"_cleanup",
			
			 // Hitme/Enemy:
			"_hurt",
			"_death",
			
			 // Projectile:
			"_anim",
			"_wall",
			"_hit",
			
			 // Slash:
			"_grenade",
			"_projectile"
		]){
			var _var =  "on" + self,
				_scr = _name + self;
			
			if(mod_script_exists("mod", mod_current, _scr)){
				var _ref = script_ref_create_ext("mod", mod_current, _scr);
				variable_instance_set(o, _var, _ref);
			}
			
			else {
				switch(self) {
					case "_step": 
						if(instance_is(o, CustomEnemy)) o.on_step = script_ref_create_ext("mod", mod_current, "enemy_step"); 
						else if(instance_is(o, CustomHitme)) o.on_step = script_ref_create_ext("mod", mod_current, "hitme_step"); 
					break;
					case "_hurt": if(instance_is(o, hitme)) o.on_hurt = script_ref_create_ext("mod", mod_current, "enemy_hurt"); break;
					case "_death": if(instance_is(o, CustomEnemy)) o.on_death = script_ref_create_ext("mod", mod_current, "enemy_death"); break;
					case "_draw": if(instance_is(o, CustomEnemy)) o.on_draw = script_ref_create_ext("mod", mod_current, "draw_self_enemy"); break;
				}
			}
			
			if(instance_is(o, hitme)) {
				if(variable_instance_exists(o, "spr_idle")) o.sprite_index = o.spr_idle;
				if(instance_is(o, CustomEnemy)) o.target = noone;
			}
		}
		
		for(var i = 0; i <= 11; i++) {
			var _alrm = "_alrm" + string(i);
			
			if(mod_script_exists("mod", mod_current, string(_name) + _alrm)){
				var _ref = script_ref_create_ext("mod", mod_current, string(_name) + _alrm);
				variable_instance_set(o, "on" + _alrm, _ref);
			}
		}
	}
	
	else {
		o = global.obj_list;
	}
	
	 // Important:
	return o;

#define step
	with(instances_matching(Sniper, "eliteified", null)) {
		eliteified = true;
		if(chance(1 + (instance_exists(GameCont) ? GameCont.loops * 3 : 0), 20)) {
			obj_create(x, y, "EliteSniper");
			instance_delete(self);
		}
	}
	
	with(instances_matching(Bandit, "eliteified", null)) {
		eliteified = true;
		if(instance_exists(GameCont) and GameCont.area = 1 and chance(min(1 + (instance_exists(GameCont) ? GameCont.loops * 3 : 0), 10), 20)) {
			obj_create(x, y, "HeavyBandit");
			instance_delete(self);
		}
	}
	
	if(instance_exists(GameCont) and GameCont.area = 101) with(instances_matching(Crab, "jellified", null)) {
		jellified = true;
		if(chance(1, 3)) obj_create(x, y, "Jelly");
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
			fx(x, y, [direction + 180 + orandom(4), 1 + random(2)], FishBoost);
		}
	}

#define AnglerFish_alrm1
	alarm1 = 40 + irandom(10);
	
	if(enemy_target(x, y) and target_visible) {
		if(target_distance < 108 and chance(2, 3)) {
			alarm1 = 40 + irandom(10);
			gunangle = target_direction + orandom(10);
			
			repeat(4) {
				fx(x, y, [gunangle + 180 + orandom(20), 1 + random(2)], FishBoost);
			}
			
			fx(x, y, 0, AssassinNotice);
			
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
			sound_play_pitchvol(sndToxicBarrelGas, 0.5 + random(0.2), 0.4);
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
		fx(x, y, [gunangle + orandom(20), 3 + random(3)], Dust);
	}
	
	image_angle = 0;
	
	sound_play_pitchvol(sndSwapFlame, 2.4 + random(0.2), 0.4);
	sound_play_pitchvol(sndFlameCannonEnd, 2.8 + random(0.2), 0.2);

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
		maxhealth   = 24;
		raddrop     = 14;
		size        = 2;
		walk	    = 0;
		walkspeed   = 0.8;
		maxspeed    = 2;
		gunangle    = random(360);
		direction   = gunangle;
		detonate    = 0;
		
		 // Alarms:
		alarm1 = 60 + irandom(10);
		
		return self;
	}

#define EliteSniper_step
	enemy_step();
	if(alarm2_run) exit;

#define EliteSniper_hurt(_damage, _force, _direction)
	my_health -= _damage;           // Damage
	nexthurt = current_frame + 6;   // I-Frames
	motion_add(_direction, _force); // Knockback
	sound_play_at(x, y, snd_hurt, 0.6 + random(0.2), 1, 64, 1);  // Sound
	
	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index  = 0;

#define EliteSniper_alrm1
	alarm1 = 60 + irandom(10);
	
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
			projectile_create(self, x + (lengthdir_x(12, gunangle + ang) * abs(sign(ang))), y + (lengthdir_y(12, gunangle + ang) * abs(sign(ang))), EnemyBullet4, gunangle, 16);
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
				projectile_create(self, x + (lengthdir_x(12, gunangle+ ang) * abs(sign(ang))), y + (lengthdir_y(12, gunangle + ang) * abs(sign(ang))), EnemyBullet4, gunangle, 16);
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
	obj_create(x, y, "EliteSniperDeath").depth = depth;

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
		maxhealth  = 20;
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
	pickup_drop(60, 10, 2);

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
			if(target_distance > 32 and chance(1, 3)) {
				alarm1 = 30 + irandom(20);
				gunangle = target_direction + orandom(10);
				direction = gunangle;
				
				fx(x, y, 0, WepSwap).depth = depth - 1;
				fx(x, y, 0, AssassinNotice);
				
				alarm2 = 16 + irandom(8);
				
				sound_play_pitchvol(sndSwapPistol, 1.2 + random(0.2), 0.4);
			}
			
			else {
				gunangle = target_direction + orandom(40) + 180;
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
		fx(x, y, [gunangle + orandom(10), 2 + random(3)], Smoke)
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
			
			projectile_create(self, x, y, EnemyBullet1, gunangle, 4);
			sound_play_pitch(sndEnemyFire, 1 + random(0.2));
			direction = gunangle;
			motion_add(direction + 180, 1);
			
			wait 2 + irandom(3);
		}
		
		exit;
	}

#define HeavyBandit_draw
	draw_self_gun();
	
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
		with(obj_create(x, y, "Guppy")) motion_add(random(360), 4);
	}
	
	if(chance(1, 2)) obj_create(x, y, BoneFish);
	
	fx(x, y, 0, ExploderExplo);
	pickup_drop(70, 20, 2);
	
	sound_play_pitch(sndOasisExplosionSmall, 0.6 + random(0.2));

#define goldsalamander_create(_x,_y)
with instance_create(_x,_y,CustomEnemy){
	name = "goldsalamander"
	team = 1
	spr_idle = sprSalamanderIdle
	spr_walk = sprSalamanderWalk
	spr_hurt = sprSalamanderHurt
	spr_dead = sprSalamanderDead
	sprite_index = spr_idle;
	hitid = [spr_idle,"golden salamander"]
	snd_hurt = sndSalamanderHurt
	snd_dead = sndSalamanderDead
	on_death = goldsalamander_death
	maxhealth = 40 + (10*instance_number(Player))
	direction = random(360)
	spr_shadow = shd64
	size = 2
	mask_index = mskScrapBoss
	friction = 0.8
	canmelee = 1
	meleedamage = 2
	target = 0
	targetvisible = 0
	fire = 150
	walk = 0
	raddrop = 20
	charging = 0
	gunangle = random(360)
	return id;
	}
#define goldsalamander_step
if(nexthurt > current_frame){
	if(sprite_index != spr_hurt) {
		image_index = 0;
		sprite_index = spr_hurt;}
		}
	else{
		if(speed > friction)
			sprite_index = spr_walk;
		else 
			sprite_index = spr_idle;
			}
if(instance_exists(Player))
	target = instance_nearest(x,y,Player);
else 
	target = 0;
	
if(instance_exists(target) && collision_line(x,y,target.x,target.y,Wall,0,0) < 0){
	targetvisible = 1;
	gunangle = point_direction(x,y,target.x,target.y)
	}
else
	targetvisible = 0;	
	
if(target > 0){
	if(targetvisible){
		var p = instance_nearest(x,y,Player)
		fire -= 1
		if(target.x > x)
			image_xscale = 1
		else
			image_xscale = -1
		}
	}

if fire > 0
	fire -= 1
if fire <= 0 and charging = 0 and targetvisible{
	sound_play(sndSalamanderCharge)
	charging = 1
	fire = 300
	}
if charging >= 1{
	sound_loop(sndSalamanderCharge)
	walk = 0
	speed = 0
	spr_idle = sprSalamanderFire
	sprite_index = spr_idle
	charging += 2.5
	if image_index > 6
		image_index = 6
	with instance_create(x+(30*right)+random_range(-60+(charging/5),60-(charging/5)),y+random_range(-60+(charging/5),60-(charging/5)),Dust){
		motion_set(point_direction(x,y,other.x+(30*other.right),other.y)+15,3+(other.charging/50))
		sprite_index = sprSmoke
		image_xscale = other.charging/100
		image_yscale = image_xscale
		}
	if charging >= 100{
		sound_stop(sndSalamanderCharge)
		var dir = -50
			if fork(){
				repeat 5 if instance_exists(self){
					with instance_create(x,y,Flare){
						sound_play(sndSalamanderFire)
						move_contact_solid(other.gunangle, 6);
						motion_add(other.gunangle + dir + (random_range(-8, 8)), random_range(6,9));
						image_angle = direction;
						hitid = [sprSalamanderFire,"golden salamander"];
						team = other.team;
						creator = other;
						}
					dir += 20
					wait 1
					}
				}
		charging = 0
		spr_idle = sprSalamanderIdle
		walk = 25
		}
	}
if targetvisible == 1 and charging <= 0 and random(10)>9{
	direction = gunangle
	walk = 25
	}
if walk > 0 and charging <= 0{
	walk -= 1
	motion_add(direction, 0.8)
	}
if speed > 2.5
	speed = 2

if targetvisible == 0 and charging<=0 and (random(50)<1){
	direction = random(360)
	walk = 25+random(10)
	}
#define goldsalamander_death
sound_stop(sndSalamanderCharge)

#macro  spr                                                                                     global.spr
#macro  snd                                                                                     global.snd
#macro  msk                                                                                     spr.msk
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

#define fx(_x, _y, _motion, _object)
	/*
		Creates a given Effect object with the given motion applied
		Automatically reorients the effect towards its new direction
		
		Args:
			x/y    - Spawn position, can be a 2-element array for [position, randomized offset]
			motion - Can be a speed to apply toward a random direction, or a 2-element array to apply a [direction, speed]
			object - The effect's object index, or an NT:TE object name
			
		Ex:
			fx([x, 4], [y, 4], 3, Dust)
			fx(x, y, [90 + orandom(30), random(3)], AcidStreak);
	*/
	
	with(obj_create(
		(is_array(_x) ? (_x[0] + orandom(_x[1])) : _x),
		(is_array(_y) ? (_y[0] + orandom(_y[1])) : _y),
		_object
	)){
		var _face = (image_angle == direction || (speed == 0 && (object_index == AcidStreak || object_index == BloodStreak)));
		
		 // Motion:
		if(is_array(_motion)){
			motion_add(_motion[0], _motion[1]);
		}
		else{
			motion_add(random(360), _motion);
		}
		
		 // Facing:
		if(_face){
			image_angle = direction;
		}
		
		return self;
	}
	
	return noone;

#define hitme_step
	if(place_meeting(x + hspeed, y + vspeed, Wall)) move_bounce_solid(true);
	
	 // Handle enemies:
	with(instances_meeting(x, y, enemy)){
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
	
#define instances_meeting(_x, _y, _obj)
	/*
		Returns all instances whose bounding boxes overlap the calling instance's bounding box at the given position
		Much better performance than manually performing 'place_meeting(x, y, other)' on every instance
	*/
	
	var	_tx = x,
		_ty = y;
		
	x = _x;
	y = _y;
	
	var _inst = instances_matching_ne(instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", bbox_left), "bbox_left", bbox_right), "bbox_bottom", bbox_top), "bbox_top", bbox_bottom), "id", id);
	
	x = _tx;
	y = _ty;
	
	return _inst;

#define instance_nearest_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns the instance closest to a given rectangle based on their position
		If multiple instances are equally distant from the rectangle, a bias exists for the one closer to its center
		Accepts an array argument like 'instance_nearest_array()' does
		
		Ex:
			instance_nearest_rectangle(x, y, x + 160, y + 64, chestprop)
	*/
	
	var	_cx      = (_x1 + _x2) / 2,
		_cy      = (_y1 + _y2) / 2,
		_disAMax = infinity,
		_disBMax = infinity,
		_nearest = noone;
		
	with(instances_matching_ne(_obj, "id")){
		var	_disA = point_distance(x, y, clamp(x, _x1, _x2), clamp(y, _y1, _y2)),
			_disB = point_distance(x, y, _cx, _cy);
			
		if(_disA < _disAMax || (_disA == _disAMax && _disB < _disBMax)){
			_disAMax = _disA;
			_disBMax = _disB;
			_nearest = self;
		}
	}
	
	return _nearest;

#define player_swap(_player)
	/*
		Cycles the given player's weapon slots
	*/
	
	with(["%wep", "%curse", "%reload", "%wkick", "%wepflip", "%wepangle", "%can_shoot", "%clicked", "%interfacepop", "drawempty%"]){
		var	_name = [string_replace(self, "%", ""), string_replace(self, "%", "b")],
			_temp = variable_instance_get(_player, _name[0], 0);
			
		variable_instance_set(_player, _name[0], variable_instance_get(_player, _name[1], 0));
		variable_instance_set(_player, _name[1], _temp);
	}

#define projectile_create // inst, x, y, obj, dir=0, spd=0
	/*
		Creates a given projectile with the given motion applied
		Automatically sets 'team', 'creator', and 'hitid' based on the given instance
		Automatically applies Euphoria to the projectile if the creator is an enemy
		
		Ex:
			projectile_create(self, x, y, Bullet2, gunangle + orandom(30 * accuracy), 16)
			projectile_create(self, x, y, "DiverHarpoon", gunangle, 7)
			projectile_create(self, x, y, Explosion)
	*/
	
	var	_inst = argument[0],
		_x    = argument[1],
		_y    = argument[2],
		_obj  = argument[3],
		_dir  = ((argument_count > 4) ? argument[4] : 0),
		_spd  = ((argument_count > 5) ? argument[5] : 0),
		_proj = obj_create(_x, _y, _obj);
		
	with(_proj){
		 // Motion:
		direction += _dir;
		if(_spd != 0){
			motion_add(_dir, _spd);
		}
		image_angle += direction;
		
		 // Auto Setup:
		var	_team    = (("team" in _inst) ? _inst.team : (("team" in self) ? team : -1)),
			_creator = (("creator" in _inst && !instance_is(_inst, hitme)) ? _inst.creator : _inst);
			
		projectile_init(_team, _creator);
		
		if("team"    in self) team    = _team;
		if("creator" in self) creator = _creator;
		if("hitid"   in self) hitid   = (("hitid" in _inst) ? _inst.hitid : hitid);
		
		 // Euphoria:
		if(
			is_string(_obj)
			&& skill_get(mut_euphoria) != 0
			&& (instance_exists(_creator) ? instance_is(_creator, enemy) : (_team != 2))
			&& !instance_is(self, EnemyBullet1)
			&& !instance_is(self, EnemyBullet3)
			&& !instance_is(self, EnemyBullet4)
			&& !instance_is(self, HorrorBullet)
			&& !instance_is(self, IDPDBullet)
			&& !instance_is(self, PopoPlasmaBall)
			&& !instance_is(self, LHBouncer)
			&& !instance_is(self, FireBall)
			&& !instance_is(self, ToxicGas)
			&& !instance_is(self, Shank)
			&& !instance_is(self, Slash)
			&& !instance_is(self, EnemySlash)
			&& !instance_is(self, GuitarSlash)
			&& !instance_is(self, CustomSlash)
			&& !instance_is(self, BloodSlash)
			&& !instance_is(self, LightningSlash)
			&& !instance_is(self, EnergyShank)
			&& !instance_is(self, EnergySlash)
			&& !instance_is(self, EnergyHammerSlash)
			&& !instance_is(other, FireCont)
		){
			script_bind_begin_step(projectile_euphoria, 0, self);
		}
	}
	
	return _proj;
	
#define projectile_euphoria(_inst)
	with(_inst){
		speed *= power(0.8, skill_get(mut_euphoria));
	}
	instance_destroy();

#define sound_play_at // x, y, sound, pitch=1, volume=1, fadeDis=64, fadeFactor=1
	/*
		Plays the given sound with a volume based on the given position's distance to the nearest local Player
		Also takes advantage of surround sound systems like headphones to make the sound appear "3D"
		Volume = (playerDis / fadeDis) ^ -fadeFactor
		
		Args:
			x/y        - The sound's position
			sound      - The sound index to play
			pitch      - The played sound's initial pitch, defaults to 1
			volume     - The played sound's initial volume, defaults to 1 (combines with the fade effect)
			fadeDis    - The distance at which the sound begins to fade in volume
			fadeFactor - Determines how fast the sound's volume falls off after the 'fadeDis'
			
		Ex:
			sound_play_at(x, y, snd_hurt, 1 + orandom(0.1))
			sound_play_at(x, y, sndExplosion, 1 + orandom(0.1), 1, 320)
	*/
	
	var	_x          = argument[0],
		_y          = argument[1],
		_sound      = argument[2],
		_pitch      = ((argument_count > 3) ? argument[3] : 1),
		_volume     = ((argument_count > 4) ? argument[4] : 1),
		_fadeDis    = ((argument_count > 5) ? argument[5] : 64),
		_fadeFactor = ((argument_count > 6) ? argument[6] : 1),
		_listenX    = view_xview_nonsync + (game_width  / 2),
		_listenY    = view_yview_nonsync + (game_height / 2);
		
	 // Determine Listener Position:
	if(instance_exists(Player)){
		var _disMax = infinity;
		with(Player){
			var _dis = point_distance(x, y, _x, _y);
			if(_dis < _disMax){
				if(player_is_local_nonsync(index)){
					_disMax = _dis;
					_listenX = x;
					_listenY = y;
				}
			}
		}
	}
	
	 // Play Sound:
	audio_stop_sound(_sound);
	var _snd = audio_play_sound_at(_sound, _listenX - _x, _listenY - _y, 0, _fadeDis, 320, _fadeFactor, false, 0);
	audio_sound_pitch(_snd, _pitch);
	audio_sound_gain(_snd, _volume * audio_sound_get_gain(_snd), 0);
	
	return _snd;
	
#define pool(_pool)
	/*
		Accepts a LWO or array of value:weight pairs, and returns one of the values based on random chance
		
		Ex:
			pool({
				"A" : 4, // 50%
				"B" : 3, // 37.5%
				"C" : 1  // 12.5%
			})
			pool([
				[Bandit,    5], // 50%
				[Scorpion,  3], // 30%
				[BigMaggot, 1], // 10%
				[Maggot,    1]  // 10%
			])
	*/
	
	 // Turn LWO Into Array:
	if(is_object(_pool)){
		var _poolNew = [];
		for(var i = 0; i < lq_size(_pool); i++){
			array_push(_poolNew, [lq_get_key(_pool, i), lq_get_value(_pool, i)]);
		}
		_pool = _poolNew;
	}
	
	 // Roll Max Number:
	var _roll = 0;
	with(_pool){
		_roll += self[1];
	}
	_roll -= random(_roll);
	
	 // Find Rolled Value:
	if(_roll > 0){
		with(_pool){
			_roll -= self[1];
			if(_roll <= 0){
				return self[0];
			}
		}
	}
	
	return null;