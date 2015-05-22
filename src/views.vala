using SDL;


class View : Object {
    protected unowned SDL.Renderer renderer;

    protected RenderComponent renderComponent = null;
    protected InputComponent inputComponent = null;


    public virtual void setRenderer(SDL.Renderer r) {
        renderer = r;
    }

    public virtual bool handle(Event e) {
        if(inputComponent ==  null) {
            return false;
        }

        return inputComponent.handle(e);
    }

    public virtual void render() {
        if(renderComponent ==  null) {
            return;
        }

        renderComponent.render(renderer);
    }
}

class SceneView : View {
    public SceneView() {
        renderComponent = new SceneRenderComponent();
        inputComponent = new SceneInputComponent();
    }
}
