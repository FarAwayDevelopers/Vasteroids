using SDL;


class Entity : Object {
    protected RenderComponent renderComponent = null;
    protected InputComponent inputComponent = null;
    protected PhysicComponent physicComponent = null;

    public int x { get; set; default = 100; }
    public int y { get; set; default = 100; }


    public virtual bool handle(Event e) {
        if(inputComponent ==  null) {
            return false;
        }

        return inputComponent.handle(e);
    }

    public virtual void render(SDL.Renderer renderer) {
        if(renderComponent ==  null) {
            return;
        }

        renderComponent.render(renderer);
    }

    public virtual void update() {
        if(physicComponent ==  null) {
            return;
        }

        physicComponent.update();
    }
}

class Spaceship : Entity {
    public Spaceship() {
        renderComponent = new SpaceshipRenderComponent.with_entity(this);
        inputComponent = new SpaceshipInputComponent.with_entity(this);
        physicComponent = new SpaceshipPhysicComponent.with_entity(this);
    }

    public void setVX(double vx) {
        ((SpaceshipPhysicComponent) physicComponent).vx = vx;
    }

    public void setVY(double vy) {
        ((SpaceshipPhysicComponent) physicComponent).vy = vy;
    }

    public void setSteadyX(bool steady) {
        ((SpaceshipPhysicComponent) physicComponent).steadyX = steady;
    }

    public void setSteadyY(bool steady) {
        ((SpaceshipPhysicComponent) physicComponent).steadyY = steady;
    }
}
