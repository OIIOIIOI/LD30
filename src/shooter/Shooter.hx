package shooter;

import flash.display.Sprite;
import flash.events.MouseEvent;
import screen.Screen;
import shooter.entities.Asteroid;
import shooter.entities.Bullet;
import shooter.entities.Enemy;
import shooter.entities.Entity;
import shooter.entities.Player;
import shooter.entities.Shield;

 /* ...
 * @author 01101101
 */

class Shooter extends Screen {
	
	static public var SPAWN_DELAY:Int = 90;
	
	var entities:Array<Entity>;
	
	var bg:Sprite;
	var player:Player;
	
	var lockedEntity:Entity;
	var shield:Shield;
	
	var spawnTimer:Int;
	
	public function new () {
		super();
		
		bg = new Sprite();
		bg.graphics.beginFill(0xFF00FF, 0.1);
		bg.graphics.drawRect(0, 0, 900, 600);
		bg.graphics.endFill();
		addChild(bg);
		bg.buttonMode = true;
		bg.addEventListener(MouseEvent.CLICK, clickHandler);
		
		entities = new Array();
		
		for (i in 0...10) {
			var e = new Asteroid();
			e.x = Std.random(900);
			e.y = Std.random(600);
			addChild(e.sprite);
			e.sprite.addEventListener(MouseEvent.CLICK, clickHandler);
			entities.push(e);
		}
		
		for (i in 0...3) {
			var e = new Enemy();
			e.x = Std.random(900);
			e.y = Std.random(600);
			addChild(e.sprite);
			entities.push(e);
		}
		
		player = new Player();
		player.x = 450;
		player.y = 300;
		addChild(player.sprite);
		entities.push(player);
		
		// Collisions
		for (i in 0...entities.length) {
			for (j in i+1...entities.length) {
				checkCollisions(entities[i], entities[j], true);
			}
		}
		
		spawnTimer = SPAWN_DELAY;
	}
	
	function clickHandler (ev:MouseEvent) {
		if (lockedEntity == null && Std.is(ev.currentTarget, EntitySprite)) {
			var e:Entity = cast(ev.currentTarget, EntitySprite).entity;
			if (!e.lockable)	return;
			e.dx = e.dy = 0;
			lockedEntity = e;
			// Shield
			shield = new Shield();
			shield.x = e.x;
			shield.y = e.y;
			addChild(shield.sprite);
			entities.push(shield);
		} else if (lockedEntity != null) {
			var angle = Math.atan2(player.y - ev.stageY, player.x - ev.stageX);
			lockedEntity.dx = Math.cos(angle) * -8;
			lockedEntity.dy = Math.sin(angle) * -8;
			lockedEntity = null;
			if (shield != null)	shield.dead = true;
		}
	}
	
	override public function update () {
		super.update();
		
		if (spawnTimer > 0) {
			spawnTimer--;
			if (spawnTimer == 0) {
				spawnAsteroid();
				spawnTimer = SPAWN_DELAY;
			}
		}
		
		//AI
		for (e in entities.filter(filterEnemies)) {
			var ee = cast(e, Enemy);
			if (ee.shootTimer == 0)	defend(ee);
			if (ee.shootTimer == 0)	shoot(ee, player);
		}
		
		// Collisions
		for (i in 0...entities.length) {
			for (j in i+1...entities.length) {
				checkCollisions(entities[i], entities[j]);
			}
		}
		
		// LockedEntity
		if (lockedEntity != null) {
			var angle = Math.atan2(player.y - mouseY, player.x - mouseX);
			lockedEntity.x = player.x + Math.cos(angle) * -(player.radius + lockedEntity.radius + 10);
			lockedEntity.y = player.y + Math.sin(angle) * -(player.radius + lockedEntity.radius + 10);
			if (shield != null) {
				shield.x = lockedEntity.x;
				shield.y = lockedEntity.y;
			}
		}
		
		// Update
		for (e in entities) {
			e.update();
		}
		// Filter dead
		entities = entities.filter(filterDead);
	}
	
	function filterEnemies (e:Entity) :Bool {	return e.type == EEType.TEnemy; }
	function filterBullets (e:Entity) :Bool {	return e.type == EEType.TBullet; }
	function filterAsteroids (e:Entity) :Bool {	return e.type == EEType.TAsteroid; }
	
	function defend (e:Enemy) {
		var shortestDist:Float = 9999;
		var closest:Asteroid = null;
		
		for (f in entities.filter(filterAsteroids)) {
			var distX = e.x - f.x;
			var distY = e.y - f.y;
			var dist = Math.sqrt(distX * distX + distY * distY);
			var totalRad = e.dangerZone + f.radius;
			if (dist < totalRad && dist < shortestDist) {
				shortestDist = dist;
				closest = cast(f);
			}
		}
		
		if (closest != null) {
			shoot(e, closest);
		}
	}
	
	function shoot (from:Entity, towards:Entity) {
		var angle = Math.atan2(from.y - towards.y, from.x - towards.x);
		
		var b = new Bullet();
		b.x = from.x - Math.cos(angle) * (from.radius + b.radius + 2);
		b.y = from.y - Math.sin(angle) * (from.radius + b.radius + 2);
		b.dx = Math.cos(angle) * -b.speed;
		b.dy = Math.sin(angle) * -b.speed;
		addChild(b.sprite);
		entities.push(b);
		
		if (from.type == EEType.TEnemy) {
			cast(from, Enemy).shootTimer = Enemy.SHOOT_DELAY;
		}
	}
	
	function spawnAsteroid () {
		var e = new Asteroid();
		
		var rx = Std.random(3);
		var ry = Std.random(3);
		if (rx == 2)	ry = Std.random(2);
		
		e.x = switch (rx) {
			case 0:		-e.radius;
			case 1:		900 + e.radius;
			default:	Std.random(900);
		}
		e.y = switch (ry) {
			case 0:		-e.radius;
			case 1:		600 + e.radius;
			default:	Std.random(600);
		}
		
		var angle = Math.atan2(e.y - Std.random(600), e.x - Std.random(900));
		e.dx = Math.cos(angle) * -e.speed;
		e.dy = Math.sin(angle) * -e.speed;
		
		addChild(e.sprite);
		e.sprite.addEventListener(MouseEvent.CLICK, clickHandler);
		entities.push(e);
	}
	
	function checkCollisions (e:Entity, f:Entity, first:Bool = false) {
		var distX = e.x - f.x;
		var distY = e.y - f.y;
		var dist = Math.sqrt(distX * distX + distY * distY);
		var totalRad = e.radius + f.radius;
		if (dist < totalRad) {
			//if (e == lockedEntity || f == lockedEntity || e == shield || f == shield)	trace(e.type + " vs " + f.type);
			// Avoid overlap
			if (first) {
				var d = Math.ceil((totalRad - dist) / 2);
				
				var eAngle = Math.atan2(e.y - f.y, e.x - f.x);
				e.x += Math.cos(eAngle) * d;
				e.y += Math.sin(eAngle) * d;
				
				var fAngle = Math.atan2(f.y - e.y, f.x - e.x);
				f.x += Math.cos(fAngle) * d;
				f.y += Math.sin(fAngle) * d;
				
				return;
			}
			// If same type
			if (e.type == EEType.TAsteroid && f.type == EEType.TAsteroid) {
				var edx = (e.dx * (e.radius - f.radius) + (2 * f.radius * f.dx)) / totalRad;
				var edy = (e.dy * (e.radius - f.radius) + (2 * f.radius * f.dy)) / totalRad;
				var fdx = (f.dx * (f.radius - e.radius) + (2 * e.radius * e.dx)) / totalRad;
				var fdy = (f.dy * (f.radius - e.radius) + (2 * e.radius * e.dy)) / totalRad;
				
				e.dx = edx;
				e.dy = edy;
				f.dx = fdx;
				f.dy = fdy;
				
				e.x += e.dx;
				e.y += e.dy;
				f.x += f.dx;
				f.y += f.dy;
			}
			else if (e.type == EEType.TPlayer && (f.type == EEType.TBullet || f.type == EEType.TAsteroid)) {
				e.damage();
				f.damage();
			}
			else if (f.type == EEType.TPlayer && (e.type == EEType.TBullet || e.type == EEType.TAsteroid)) {
				f.damage();
				e.damage();
			}
			else if (e.type == EEType.TEnemy && f.type == EEType.TAsteroid) {
				e.damage();
				f.damage();
			}
			else if (f.type == EEType.TEnemy && e.type == EEType.TAsteroid) {
				e.damage();
				f.damage();
			}
			else if (e.type == EEType.TBullet && f.type == EEType.TAsteroid ||
					e.type == EEType.TAsteroid && f.type == EEType.TBullet ||
					e.type == EEType.TBullet && f.type == EEType.TShield ||
					e.type == EEType.TShield && f.type == EEType.TBullet) {
				/*if (e != lockedEntity)	e.damage();
				if (f != lockedEntity)	f.damage();*/
				e.damage();
				f.damage();
			}
		}
	}
	
	function filterDead (e:Entity) :Bool {
		var dead = e.dead || e.x < 0 - e.radius - 50 || e.x > 900 + e.radius + 50 || e.y < 0 - e.radius - 50 || e.y > 600 + e.radius + 50;
		if (dead) {
			if (e.sprite.parent != null)	e.sprite.parent.removeChild(e.sprite);
			if (e.sprite.hasEventListener(MouseEvent.CLICK))	e.sprite.removeEventListener(MouseEvent.CLICK, clickHandler);
			if (e == lockedEntity) {
				lockedEntity = null;
				shield.dead = true;
			} else if (e == shield) {
				shield = null;
			}
		}
		return !dead;
	}
	
	override public function kill () {
		super.kill();
		
		while (entities.length > 0)	entities.shift();
		entities = null;
	}
	
}
