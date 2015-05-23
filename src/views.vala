using SDL;
using Gee;


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
    private ArrayList<Entity> entities;

    public SceneView() {
        entities = new ArrayList<Entity>();
    }

    public void addEntity(Entity e) {
        entities.add(e);
    }

    public override void render() {
        Iterator<Entity> iter = entities.iterator();
        while(iter.next()) {
            Entity e = iter.get();
            e.render(renderer);
        }
    }

    public override bool handle(Event ev) {
        Iterator<Entity> iter = entities.iterator();
        while(iter.next()) {
            Entity e = iter.get();
            e.handle(ev);
        }

        return false;
    }

    public override void update() {
        Iterator<Entity> iter = entities.iterator();
        while(iter.next()) {
            Entity e = iter.get();
            e.update();
        }
    }
}
