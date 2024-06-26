class Mouse {
    public _buttons: Button[]
    public _light: Light
    public _shape: Shape
    public _position: Position
    public _scroll: Scroll
    public _dpi: DPI
    public _device: Device[]


    constructor(buttons: Button[], light: Light, shape: Shape, position: Position, scroll: Scroll, dpi: DPI, device: Device[]) {
        this._buttons = buttons;
        this._light = light;
        this._shape = shape
        this._position = position
        this._scroll = scroll
        this._dpi = dpi
        this._device = device
    }

    click(buttonname: string) {
        const button = this._buttons.find(btn => btn._name === buttonname);
        if (button) {
            button.click()
        }
        else {
            console.log(`Button ${buttonname} not found `)
        }
    }
    doubleclick(buttonname: string) {
        const button = this._buttons.find(btn => btn._name === buttonname);
        if (button) {
            button.doubleclick()
        }
        else {
            console.log(`Button ${buttonname} not found `)
        }
    }
    scroll(scrolldirection: string) {
        this._scroll.scroll(scrolldirection)
    }
    changeLightColor(newColor: string) {
        this._light.changeColor(newColor)
    }
    increaseLightBrightness(amount: number) {
        this._light.increaseBrightness(amount)
    }
    decreaseLightBrightness(amount: number) {
        this._light.decreaseBrightness(amount)
    }
    increaseDpiSens(amount: number) {
        this._dpi.increaseSens(amount)
    }
    decreaseDpiSens(amount: number) {
        this._dpi.decreaseSens(amount)
    }
    move(xchange: number, ychange: number): Position {
        this._position._x += xchange
        this._position._y += ychange
        return this._position
    }

    getMaxScreenSize() {
        let totalWidth = 0;
        for (const device of this._device) {

            totalWidth += device._widthscreen;
        }
        console.log(totalWidth)
        return totalWidth
    }
}

class Button {
    public _name: string
    public _shape: Shape

    constructor(name: string, shape: Shape) {
        this._name = name
        this._shape = shape
    }

    click() {
        console.log(`Click on button ${this._name}`)
    }
    doubleclick() {
        console.log(`Double click on button ${this._name}`)
    }
}
class Scroll {
    public _shape: Shape
    public _scroll_direction: string[]

    constructor(shape: Shape, scroll_dicrection: string[]) {
        this._shape = shape
        this._scroll_direction = scroll_dicrection
    }
    scroll(dicrection: string) {
        if (this._scroll_direction.includes(dicrection))
            console.log(`Scrolled ${dicrection}`)
    }

}

class Light {
    public _color: string
    public _brightness: number



    constructor(color: string, brightness: number) {
        this._color = color
        this._brightness = brightness
    }

    changeColor(newColor: string) {
        this._color = newColor
        console.log(`Light color changed to ${newColor}`)
    }
    increaseBrightness(amount: number) {
        this._brightness += amount
        console.log(`Brightness increased to ${this._brightness}`)
    }
    decreaseBrightness(amount: number) {
        this._brightness -= amount
        console.log(`Brightness decreased to ${this._brightness}`)
    }
}

class Shape {
    public _width: number
    public _height: number

    constructor(width: number, height: number) {
        this._width = width
        this._height = height
    }
}

class Position {
    public _x: number
    public _y: number


    constructor(x: number, y: number) {
        this._x = x
        this._y = y
    }

}

class DPI {
    public _sensitivity: number


    constructor(sensitivity: number) {
        this._sensitivity = sensitivity
    }

    increaseSens(amount: number) {
        this._sensitivity += amount
        console.log(`Sensitivity increased to ${this._sensitivity}`)
    }
    decreaseSens(amount: number) {
        this._sensitivity -= amount
        console.log(`Sensitivity decreased to ${this._sensitivity}`)
    }
}

class Device {
    public _widthscreen: number
    public _heightscreen: number

    constructor(widthscreen: number, heightscreen: number) {
        this._widthscreen = widthscreen
        this._heightscreen = heightscreen
    }
}




// shape
const rectangular = new Shape(30, 20)
const circular = new Shape(10, 20)

// button
const leftButtonn = new Button('Left', rectangular)
const rightButtonn = new Button('Right', rectangular)
const nextButton = new Button('Next', rectangular)
const backButton = new Button('Back', rectangular)
// light
const pinkLight = new Light('Pink', 30)
//postion
const mousepostion = new Position(0, 0);
//scroll
const mousescroll = new Scroll(circular, ["up", "down"])
//DPI
const dpi = new DPI(800)
// device
const laptop = new Device(1920, 1080)
const LGscreen = new Device(2920, 1880)
//
const myMouse = new Mouse([leftButtonn, rightButtonn], pinkLight, rectangular, mousepostion, mousescroll, dpi, [laptop, LGscreen])
console.log(myMouse)



myMouse.click('Left')
myMouse.scroll('up')
myMouse.changeLightColor('red')
myMouse.doubleclick('Left')
myMouse.increaseLightBrightness(30)
myMouse.increaseDpiSens(300)
myMouse.move(3, 3)
myMouse.getMaxScreenSize()
console.log(myMouse)


export { Mouse, Shape, Position, Scroll, Button, Light, DPI, Device }