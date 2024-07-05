import { Mouse, Shape, Button, Scroll, Light, Position, DPI, Device } from "./Mouse"


describe("Mouse class", () => {
    let myMouse: Mouse
    beforeEach(() => {
        myMouse = new Mouse();
        myMouse._buttons = [new Button("left"), new Button("right", new Shape(30, 20))];
        myMouse._light = new Light('Pink', 30);
        myMouse._shape = new Shape(10, 20);
        myMouse._position = new Position(0, 0);
        myMouse._scroll = new Scroll(100);
        myMouse._dpi = new DPI(800);
        myMouse._device = [new Device(1920, 1080), new Device(2920, 1880)];

    })

    test('should change light color', () => {
        myMouse.changeLightColor("red");
        expect(myMouse._light._color).toBe("red");
    });


    test('should scroll up', () => {
        myMouse.scroll("up");
        expect(myMouse._scroll._status).toBe('up');
    });

    test('should click the left button', () => {
        myMouse.click("left");
        const leftButton = myMouse._buttons.find(btn => btn._name === 'left')
        expect(leftButton?._status).toBe('Click');
    });


    test('should doubleclick the left button', () => {
        myMouse.doubleclick("left");
        const leftButton = myMouse._buttons.find(btn => btn._name === 'left')
        expect(leftButton?._status).toBe('Double click');
    });

    test('should change light brightness', () => {
        myMouse.increaseLightBrightness(30);
        expect(myMouse._light._brightness).toBe(60);
    });

    test('should change sensitivity', () => {
        myMouse.increaseDpiSens(300);
        expect(myMouse._dpi._sensitivity).toBe(1100);
    });


    test('should turn light on', () => {
        myMouse._light.toggleLight()
        expect(myMouse._light._status).toBe(true)
    })

    test ('should move' ,() =>{
        myMouse.move(3,5)
        expect(myMouse._position._x).toBe(3);
        expect(myMouse._position._y).toBe(5);
    }) 

    // test('max width', () => {
    //     myMouse.getMaxScreenSize();
    //     const result = myMouse.getMaxScreenSize();
    //     expect(result).toBe(1920);
    // });
})