using GLib;
using SDL;


class InputComponent : Object {
    protected Entity *entity;

    public InputComponent.with_entity(Entity *e) {
        entity = e;
    }

    public virtual bool handle(Event e) {
        /**
         * Return true if event should not be propagated, false otherwise
         */
        switch(e.type) {
            case EventType.KEYDOWN:
            case EventType.KEYUP:
                processKey(e.key);
                break;
            default:
                break;
        }

        return false;
    }

    protected virtual void processKey(KeyboardEvent e) {

    }
}

class SpaceshipInputComponent : InputComponent {
    public SpaceshipInputComponent.with_entity(Entity *e) {
        base.with_entity(e);
    }

    protected override void processKey(KeyboardEvent e) {
        switch(e.keysym.sym) {
            case SDL.Keycode.w:
                ((Spaceship*) entity)->accelerate(0, -5);
                break;
            case SDL.Keycode.s:
                ((Spaceship*) entity)->accelerate(0, 5);
                break;
            case SDL.Keycode.a:
                ((Spaceship*) entity)->accelerate(-5, 0);
                break;
            case SDL.Keycode.d:
                ((Spaceship*) entity)->accelerate(5, 0);
                break;
        }
    }
}
