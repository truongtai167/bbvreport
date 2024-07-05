interface INode {
    addChild(node: INode): void
    removeChild(node: INode): void
    changeText(text: string): void
    changeColor(color: string): void
    changeShape(name: string): void
    changeTextSize(size: number): void
}


class MindMap {
    public rootNode: Nodee
    public otherNode: Nodee[]
    public relationship: Relationship[]
    // public theme: Theme

    constructor(rootNode: Nodee, otherNode: Nodee[] = [], relationship: Relationship[] = []) {
        this.rootNode = rootNode
        this.otherNode = otherNode
        this.relationship = relationship
        // this.theme = theme
    }

    addNode(node: Nodee) {
        this.otherNode.push(node)
    }
    removeNode(node: Nodee) {
        this.otherNode = this.otherNode.filter(n => n !== node)
    }
    addRelationship(fromNode: Nodee, toNode: Nodee, color: Color = new Color('Black'), text: Text = new Text(13, 'Arial', 'Relationship')) {
        const relationship = new Relationship(fromNode, toNode, color, text)
        this.relationship.push(relationship)
    }

    // applyThemeToNode(node: Nodee) {
    //     this.theme.applyTheme(node);
    //     node.child.forEach(childNode => {
    //         this.applyThemeToNode(childNode);
    //     });
    // }
    // applyThemeToMap() {
    //     this.applyThemeToNode(this.rootNode);
    // }
}

class Nodee implements INode {
    public child!: Nodee[]
    public color!: Color
    public shape!: Shape
    public position!: Position
    public text!: Text

    addChild(node: Nodee) {
        this.child.push(node)
    }
    removeChild(node: Nodee) {
        this.child = this.child.filter(n => n !== node)
    }
    changeText(text: string) {
        this.text.changeText(text)
    }
    changeColor(color: string) {
        this.color.changeColor(color)
    }
    changeShape(name: string) {
        this.shape.changeShape(name)
    }
    changeTextSize(size: number) {
        this.text.changeTextSize(size)
    }
}

class Relationship {
    public fromNode: Nodee
    public toNode: Nodee
    public color: Color
    public text: Text

    constructor(fromNode: Nodee, toNode: Nodee, color: Color = new Color('Black'), text: Text = new Text(13, 'Arial', 'Relation')) {
        this.fromNode = fromNode
        this.toNode = toNode
        this.color = color
        this.text = text
    }
}

class Position {
    public x: number
    public y: number

    constructor(x: number, y: number) {
        this.x = x
        this.y = y
    }
}
class Shape {
    public name: string
    public fill: boolean
    public border: boolean

    constructor(name: string = 'Rectangle', fill: boolean = false, border: boolean = false) {
        this.name = name
        this.fill = fill
        this.border = border
    }
    changeShape(name: string) {
        this.name = name
    }
}
class Color {
    public name: string

    constructor(name: string) {
        this.name = name
    }

    changeColor(newColor: string) {
        this.name = newColor
    }
}

class Text {
    public content: string
    public size: number
    public style: string

    constructor(size: number = 13, style: string = 'Arial', content: string = 'Content') {
        this.content = content
        this.size = size
        this.style = style
    }
    changeText(text: string) {
        this.content = text
    }
    changeTextSize(size: number) {
        this.size = size
    }

}
// class Theme {
//     public color: Color
//     public shape: Shape
//     public text: Text


//     constructor(color: Color, shape: Shape, text: Text) {
//         this.color = color
//         this.shape = shape
//         this.text = text
//     }

//     applyTheme(node: INode) {
//         if (node.changeColor) {
//             node.changeColor(this.color.name);
//         }
//         if (node.changeShape) {
//             node.changeShape(this.shape.name);
//         }
//         if (node.changeText) {
//             node.changeText(this.text.content);
//         }
//     }
// }



export { Nodee, Relationship, Position, Shape, Color, Text, MindMap }
