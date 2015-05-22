using GLib;
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


    public SpaceshipPhysicComponent.with_entity(Entity *e) {
        base.with_entity(e);
    }

    public override void update() {
        entity->x = (int) (entity->x + vx);
        entity->y = (int) (entity->y + vy);

        vx *= 0.95;
        vy *= 0.95;
    }
}
