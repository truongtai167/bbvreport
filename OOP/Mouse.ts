class Mouse {
    public _buttons: Button[]
    public _light: Light
    public _shape: Shape
    public _position: Position
    public _scroll: Scroll


    constructor(buttons: Button[], light: Light, shape: Shape, position: Position, scroll: Scroll) {
        this._buttons = buttons;
        this._light = light;
        this._shape = shape
        this._position = position
        this._scroll = scroll
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
    scroll(scrolldirection: string) {
        this._scroll.scroll(scrolldirection)
    }
    changeLightColor(newColor: string) {
        this._light.changeColor(newColor)
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
        console.log(this._name)
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
            console.log(dicrection)
    }

}

class Light {
    public _color: string
    public _brightness: string



    constructor(color: string, brightness: string) {
        this._color = color
        this._brightness = brightness
    }

    changeColor(newColor: string) {
        this._color = newColor
        console.log(`Light color changed to ${newColor}`)
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




// shape
const rectangular = new Shape(30, 20)
const circular = new Shape(10, 20)

// button
const leftButtonn = new Button('Left', rectangular)
const rightButtonn = new Button('Right', rectangular)
const nextButton = new Button('Next', rectangular)
const backButton = new Button('Back', rectangular)
// light
const pinkLight = new Light('Pink', '30')
//postion
const mousepostion = new Position(0, 0);
//scroll
const mousescroll = new Scroll(circular, ["up", "down"])
//
const myMouse = new Mouse([leftButtonn, rightButtonn], pinkLight, rectangular, mousepostion, mousescroll)
console.log(myMouse)

myMouse.click('Left')
myMouse.scroll('up')
myMouse.changeLightColor('Yellow')