using GLib;
using SDL;


class InputComponent : Object {
    public virtual bool handle(Event e) {
        /**
         * Return true if event should not be propagated, false otherwise
         */
        return false;
    }
}

class SceneInputComponent : InputComponent {
    public override bool handle(Event e) {
        return false;
    }
}
