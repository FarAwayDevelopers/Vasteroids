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

        switch(ke.keysym.sym) {
            case SDL.Keycode.w:
                ((Spaceship*) entity)->setSteadyY(e.type == EventType.KEYDOWN);
                if(e.type == EventType.KEYDOWN) ((Spaceship*) entity)->setVY(-5);
                break;
            case SDL.Keycode.s:
                ((Spaceship*) entity)->setSteadyY(e.type == EventType.KEYDOWN);
                if(e.type == EventType.KEYDOWN) ((Spaceship*) entity)->setVY(5);
                break;
            case SDL.Keycode.a:
                ((Spaceship*) entity)->setSteadyX(e.type == EventType.KEYDOWN);
                if(e.type == EventType.KEYDOWN) ((Spaceship*) entity)->setVX(-5);
                break;
            case SDL.Keycode.d:
                ((Spaceship*) entity)->setSteadyX(e.type == EventType.KEYDOWN);
                if(e.type == EventType.KEYDOWN) ((Spaceship*) entity)->setVX(5);
                break;
        }
    }
}
