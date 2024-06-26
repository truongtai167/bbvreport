import { Mouse, Shape, Button, Scroll, Light, Position, DPI, Device } from "./Mouse"


describe("Mouse class", () => {
    let mouse: Mouse
    let rectangular: Shape
    let leftButton: Button
    let rightButton: Button
    let mousecscroll: Scroll
    let pinkLight: Light
    let mousepostion: Position
    let dpi: DPI
    let laptop: Device

    beforeEach(() => {
        rectangular = new Shape(30, 20)
        leftButton = new Button("Left", rectangular)
        rightButton = new Button("Right", rectangular)
        mousecscroll = new Scroll(rectangular, ["up", "down"])
        pinkLight = new Light('Pink', 30)
        mousepostion = new Position(0, 0);
        dpi = new DPI(800)
        laptop = new Device(1920, 1080)
        mouse = new Mouse([leftButton, rightButton], pinkLight, rectangular, mousepostion, mousecscroll, dpi, [laptop])

    })

    test('should change light color', () => {
        console.log = jest.fn(); // Mock console.log
        mouse.changeLightColor("red");
        expect(console.log).toHaveBeenCalledWith("Light color changed to red");
        expect(mouse._light._color).toBe("red");
    });


    test('should scroll up', () => {
        console.log = jest.fn(); // Mock console.log
        mouse.scroll("up");
        expect(console.log).toHaveBeenCalledWith("Scrolled up");
    });

    test('should click the left button', () => {
        console.log = jest.fn(); // Mock console.log
        mouse.click("Left");
        expect(console.log).toHaveBeenCalledWith("Click on button Left");
    });

    test('should change light brightness', () => {
        console.log = jest.fn(); // Mock console.log
        mouse.increaseLightBrightness(30);
        expect(console.log).toHaveBeenCalledWith(`Brightness increased to ${mouse._light._brightness}`);
        expect(mouse._light._brightness).toBe(60);
    });

    test('should change sensitivity', () => {
        console.log = jest.fn(); // Mock console.log
        mouse.increaseDpiSens(300);
        expect(console.log).toHaveBeenCalledWith(`Sensitivity increased to ${mouse._dpi._sensitivity}`);
        expect(mouse._dpi._sensitivity).toBe(1100);
    });

    test('max width', () => {
        console.log = jest.fn(); // Mock console.log
        mouse.getMaxScreenSize();
        const result = mouse.getMaxScreenSize();
        expect(result).toBe(1920);
    });
})