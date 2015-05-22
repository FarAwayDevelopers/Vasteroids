using GLib;
using GLib.Math;
using SDL;


class PhysicComponent : Object {
    protected Entity *entity;

    public PhysicComponent.with_entity(Entity *e) {
        entity = e;
    }

    public virtual void update() {

    }
}

class SpaceshipPhysicComponent : PhysicComponent {
    public double vx { get; set; default = 0; }
    public double vy { get; set; default = 0; }

    public bool steadyX { get; set; default = false; }
    public bool steadyY { get; set; default = false; }


    public SpaceshipPhysicComponent.with_entity(Entity *e) {
        base.with_entity(e);
    }

    public override void update() {
        entity->x = (int) (entity->x + vx);
        entity->y = (int) (entity->y + vy);

        if(!steadyX) {
            vx *= 0.9;
            vx = (fabs(vx) < 1)?0:vx;
        }
        if(!steadyY) {
            vy *= 0.9;
            vy = (fabs(vy) < 1)?0:vy;
        }
    }
}
