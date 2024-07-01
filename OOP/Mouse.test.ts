import { Mouse, Shape, Button, Scroll, Light, Position, DPI, Device } from "./Mouse"


describe("Mouse class", () => {
    let myMouse: Mouse
    beforeEach(() => {
        myMouse = new Mouse();
        myMouse._buttons = [new Button("left", new Shape(30, 20)), new Button("right", new Shape(30, 20))];
        myMouse._light = new Light('Pink', 30);
        myMouse._shape = new Shape(10, 20);
        myMouse._position = new Position(0, 0);
        myMouse._scroll = new Scroll(new Shape(10, 20), ["up", "down"]);
        myMouse._dpi = new DPI(800);
        myMouse._device = [new Device(1920, 1080), new Device(2920, 1880)];

    })

    test('should change light color', () => {
        console.log = jest.fn(); // Mock console.log
        myMouse.changeLightColor("red");
        expect(console.log).toHaveBeenCalledWith("Light color changed to red");
        expect(myMouse._light._color).toBe("red");
    });


    test('should scroll up', () => {
        console.log = jest.fn(); // Mock console.log
        myMouse.scroll("up");
        expect(console.log).toHaveBeenCalledWith("Scrolled up");
    });

    test('should click the left button', () => {
        console.log = jest.fn(); // Mock console.log
        myMouse.click("Left");
        expect(console.log).toHaveBeenCalledWith("Click on button Left");
    });

    test('should change light brightness', () => {
        console.log = jest.fn(); // Mock console.log
        myMouse.increaseLightBrightness(30);
        expect(console.log).toHaveBeenCalledWith(`Brightness increased to ${myMouse._light._brightness}`);
        expect(myMouse._light._brightness).toBe(60);
    });

    test('should change sensitivity', () => {
        console.log = jest.fn(); // Mock console.log
        myMouse.increaseDpiSens(300);
        expect(console.log).toHaveBeenCalledWith(`Sensitivity increased to ${myMouse._dpi._sensitivity}`);
        expect(myMouse._dpi._sensitivity).toBe(1100);
    });

    test('max width', () => {
        console.log = jest.fn(); // Mock console.log
        myMouse.getMaxScreenSize();
        const result = myMouse.getMaxScreenSize();
        expect(result).toBe(1920);
    });
})