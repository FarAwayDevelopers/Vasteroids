using SDL;


class Entity : Object {
    protected RenderComponent renderComponent = null;
    protected InputComponent inputComponent = null;
    protected PhysicsComponent physicsComponent = null;

    public int x { get; set; default = 0; }
    public int y { get; set; default = 0; }


    public virtual bool handle(Event e) {
        if(inputComponent ==  null) {
            return false;
        }

        return inputComponent.handle(e);
    }

    public virtual void render(Renderer renderer) {
        if(renderComponent ==  null) {
            return;
        }

        renderComponent.render(renderer);
    }

    public virtual void update() {
        if(physicsComponent ==  null) {
            return;
        }

        physicsComponent.update();
    }
}

class Spaceship : Entity {
    public double mouseX;
    public double mouseY;


    public Spaceship.with_coordinates(int x, int y) {
        this.x = x;
        this.y = y;

        renderComponent = new SpaceshipRenderComponent.with_entity(this);
        inputComponent = new SpaceshipInputComponent.with_entity(this);
        physicsComponent = new SpaceshipPhysicsComponent.with_entity(this);
    }

    public void setVX(double vx) {
        ((SpaceshipPhysicsComponent) physicsComponent).vx = vx;
    }

    public void setVY(double vy) {
        ((SpaceshipPhysicsComponent) physicsComponent).vy = vy;
    }

    public void setSteadyX(bool steady) {
        ((SpaceshipPhysicsComponent) physicsComponent).steadyX = steady;
    }

    public void setSteadyY(bool steady) {
        ((SpaceshipPhysicsComponent) physicsComponent).steadyY = steady;
    }
}

class Background : Entity {
    public Background.with_texture(string texPath) {
        renderComponent = new BackgroundRenderComponent.with_entity(this);
        inputComponent = new BackgroundInputComponent.with_entity(this);

        ((BackgroundRenderComponent) renderComponent).setTexture(texPath);
    }
}
