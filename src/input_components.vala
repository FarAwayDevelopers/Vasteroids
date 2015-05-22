using GLib;
using SDL;


class InputComponent : Object {
    protected Entity *entity;

    protected GLib.HashTable<SDL.Keycode?, bool> keyStates;


    public InputComponent.with_entity(Entity *e) {
        entity = e;

        keyStates = new GLib.HashTable<SDL.Keycode?, bool>(str_hash, str_equal);
    }

    public virtual bool handle(Event e) {
        /**
         * Return true if event should not be propagated, false otherwise
         */
        switch(e.type) {
            case EventType.KEYDOWN:
            case EventType.KEYUP:
                processKey(e);
                break;
            default:
                break;
        }

        return false;
    }

    protected virtual void processKey(Event e) {

    }
}

class SpaceshipInputComponent : InputComponent {
    public SpaceshipInputComponent.with_entity(Entity *e) {
        base.with_entity(e);
    }

    protected override void processKey(Event e) {
        KeyboardEvent ke = e.key;
        keyStates[ke.keysym.sym] = e.type == EventType.KEYDOWN;

        ((Spaceship*) entity)->setSteadyX(keyStates[SDL.Keycode.a] || keyStates[SDL.Keycode.d]);
        ((Spaceship*) entity)->setSteadyY(keyStates[SDL.Keycode.w] || keyStates[SDL.Keycode.s]);

        if(keyStates[SDL.Keycode.w]) {
            ((Spaceship*) entity)->setVY(-5);
        }
        if(keyStates[SDL.Keycode.s]) {
            ((Spaceship*) entity)->setVY(5);
        }
        if(keyStates[SDL.Keycode.a]) {
            ((Spaceship*) entity)->setVX(-5);
        }
        if(keyStates[SDL.Keycode.d]) {
            ((Spaceship*) entity)->setVX(5);
        }
    }
}
