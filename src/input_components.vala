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
            case EventType.MOUSEMOTION:
                processMouse(e);
                break;
            default:
                break;
        }

        return false;
    }

    protected virtual void processKey(Event e) {
        KeyboardEvent ke = e.key;
        keyStates[ke.keysym.sym] = e.type == EventType.KEYDOWN;
    }

    protected virtual void processMouse(Event e) {

    }
}

class SpaceshipInputComponent : InputComponent {
    public SpaceshipInputComponent.with_entity(Entity *e) {
        base.with_entity(e);
    }

    protected override void processKey(Event e) {
        base.processKey(e);

        ((Spaceship*) entity)->setSteadyX(keyStates[SDL.Keycode.a] || keyStates[SDL.Keycode.d]);
        ((Spaceship*) entity)->setSteadyY(keyStates[SDL.Keycode.w] || keyStates[SDL.Keycode.s]);

        if(keyStates[SDL.Keycode.w]) {
            double x = Math.sin(((Spaceship*) entity)->angle/180*Math.PI) * ((Spaceship*) entity)->speed;
            double y = - Math.cos(((Spaceship*) entity)->angle/180*Math.PI) * ((Spaceship*) entity)->speed;
            ((Spaceship*) entity)->setVX(x);
            ((Spaceship*) entity)->setVY(y);
        }
        /*if(keyStates[SDL.Keycode.s]) {
            ((Spaceship*) entity)->setVY(((Spaceship*) entity)->speed);
        }
        if(keyStates[SDL.Keycode.a]) {
            ((Spaceship*) entity)->setVX(-((Spaceship*) entity)->speed);
        }
        if(keyStates[SDL.Keycode.d]) {
            ((Spaceship*) entity)->setVX(((Spaceship*) entity)->speed);
        }*/
    }

    protected override void processMouse(Event e) {
        MouseMotionEvent me = e.motion;

        ((Spaceship*) entity)->mouseX = me.x;
        ((Spaceship*) entity)->mouseY = me.y;
    }
}

class BackgroundInputComponent : InputComponent {
    public BackgroundInputComponent.with_entity(Entity *e) {
        base.with_entity(e);
    }

    protected override void processKey(Event e) {
        base.processKey(e);
    }
}
