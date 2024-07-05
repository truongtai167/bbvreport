class Mouse {
    public _buttons!: Button[]
    public _light!: Light
    public _shape!: Shape
    public _position!: Position
    public _scroll!: Scroll
    public _dpi!: DPI
    public _device!: Device[]

    click(buttonname: string) {
        this._buttons.find(btn => btn._name === buttonname)?.click()
    }
    doubleclick(buttonname: string) {
        this._buttons.find(btn => btn._name === buttonname)?.doubleclick()
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
    toggleLight() {
        this._light.toggleLight()
    }
    move(xchange: number, ychange: number): Position {
        this._position._x += xchange
        this._position._y += ychange
        return this._position
    }

    // getMaxScreenSize() {
    //     let totalWidth = 0;
    //     for (const device of this._device) {

    //         totalWidth += device._widthscreen;
    //     }
    //     console.log(totalWidth)
    //     return totalWidth
    // }
}

class Button {
    public _name: string
    public _shape: Shape
    public _status: string

    constructor(name: string, shape: Shape = new Shape(30, 20), status: string = 'default') {
        this._name = name
        this._shape = shape
        this._status = status
    }

    click() {
        this._status = 'Click'
    }
    doubleclick() {
        this._status = 'Double click'
    }
}


class Scroll {
    public _scroll_direction: string[]
    public _speed: number
    public _status: string

    constructor(speed: number, status: string = 'default', scroll_dicrection: string[] = ["up", "down"]) {
        this._scroll_direction = scroll_dicrection
        this._speed = speed
        this._status = status
    }

    scroll(dicrection: string) {
        this._status = this._scroll_direction.includes(dicrection) ? dicrection : this._status
    }


}

class Light {
    public _color: string
    public _brightness: number
    public _status: boolean



    constructor(color: string, brightness: number, status: boolean = false) {
        this._color = color
        this._brightness = brightness
        this._status = status
    }

    changeColor(newColor: string) {
        this._color = newColor
    }
    increaseBrightness(amount: number) {
        this._brightness += amount
    }
    decreaseBrightness(amount: number) {
        this._brightness -= amount
    }
    toggleLight() {
        this._status = !this._status;
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
    }
    decreaseSens(amount: number) {
        this._sensitivity -= amount
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





export { Mouse, Shape, Position, Scroll, Button, Light, DPI, Device }