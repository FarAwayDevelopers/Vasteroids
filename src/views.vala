using SDL;


class View : Object {
    protected unowned SDL.Renderer renderer;

    public virtual void setRenderer(SDL.Renderer r) {
        renderer = r;
    }

    public virtual void render() {

    }

    public virtual bool handle(Event e) {
        return false;
    }

    public virtual void update() {

    }
}

class SceneView : View {
    private Entity[] entities;

    public SceneView() {

    }

    public void addEntity(Entity e) {
        entities += e;
    }

    public override void render() {
        foreach(Entity e in entities) {
            e.render(renderer);
        }
    }

    public override bool handle(Event ev) {
        foreach(Entity e in entities) {
            e.handle(ev);
        }
        return false;
    }

    public override void update() {
        foreach(Entity e in entities) {
            e.update();
        }
    }
}
