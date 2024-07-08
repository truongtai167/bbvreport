interface INode {
    addChild(node: INode): void
    removeChild(node: INode): void
}
interface IText {
    changeText(text: string): void
    changeTextSize(size: number): void
}

interface IShape {
    changeShape(name: string): void
}

interface IColor {
    changeColor(color: string): void
}

class MindMap {
    public sheets: Sheet[];

    constructor(sheets: Sheet[] = [new Sheet()]) {
        this.sheets = sheets;
    }

    addSheet(sheet: Sheet) {
        this.sheets.push(sheet);
    }

    removeSheet(sheet: Sheet) {
        this.sheets = this.sheets.filter(s => s !== sheet);
    }
}

class Sheet {
    public rootNode: Nodee;
    public floatingNode: Nodee[];
    public relationship: Relationship[];
    public name: string
    // public theme: Theme

    constructor(rootNode: Nodee = new Nodee(new Position(0, 0), new Shape('Rectangle'), new Color('Black'), new Text(13, 'Arial', 'Central Topic')), otherNode: Nodee[] = [], relationship: Relationship[] = [], name: string = 'Mind Map') {
        this.rootNode = rootNode;
        this.floatingNode = otherNode;
        this.relationship = relationship;
        this.name = name
        // this.theme = theme
        const childNode1 = new Nodee(new Position(0, 0), new Shape('Rectangle'), new Color('Blue'), new Text(13, 'Arial', 'Main Topic 1'));
        const childNode2 = new Nodee(new Position(0, 0), new Shape('Rectangle'), new Color('Red'), new Text(13, 'Arial', 'Main Topic 2'));
        const childNode3 = new Nodee(new Position(0, 0), new Shape('Rectangle'), new Color('Yellow'), new Text(13, 'Arial', 'Main Topic 3'));
        const childNode4 = new Nodee(new Position(0, 0), new Shape('Rectangle'), new Color('Green'), new Text(13, 'Arial', 'Main Topic 4'));
        this.rootNode.addChild(childNode1);
        this.rootNode.addChild(childNode2);
        this.rootNode.addChild(childNode3);
        this.rootNode.addChild(childNode4);
    }

    addFloatingNode(node: Nodee) {
        this.floatingNode.push(node);
    }

    removeFloatingNode(node: Nodee) {
        this.floatingNode = this.floatingNode.filter(n => n !== node);
    }
    renameSheet(name: string) {
        this.name = name
    }

    addRelationship(fromNode: Nodee, toNode: Nodee, color: Color = new Color('Black'), text: Text = new Text(13, 'Arial', 'Relationship')) {
        const relationship = new Relationship(fromNode, toNode, color, text);
        this.relationship.push(relationship);
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

class Nodee implements INode, IText, IColor, IShape {
    public child: Nodee[];
    public color: Color;
    public shape: Shape;
    public position: Position;
    public text: Text;

    constructor(
        position: Position = new Position(0, 0),
        shape: Shape = new Shape(),
        color: Color = new Color('Black'),
        text: Text = new Text()
    ) {
        this.child = [];
        this.position = position;
        this.shape = shape;
        this.color = color;
        this.text = text;
    }

    addChild(node: Nodee) {
        this.child.push(node);
    }

    removeChild(node: Nodee) {
        this.child = this.child.filter(n => n !== node);
    }

    changeText(text: string) {
        this.text.changeText(text);
    }

    changeColor(color: string) {
        this.color.changeColor(color);
    }

    changeShape(name: string) {
        this.shape.changeShape(name);
    }

    changeTextSize(size: number) {
        this.text.changeTextSize(size);
    }
}

class Relationship implements IText, IColor {
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
    changeText(text: string) {
        this.text.changeText(text);
    }
    changeTextSize(size: number) {
        this.text.changeTextSize(size);
    }
    changeColor(color: string) {
        this.color.changeColor(color);
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
class Shape implements IShape {
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
class Color implements IColor {
    public name: string

    constructor(name: string) {
        this.name = name
    }

    changeColor(newColor: string) {
        this.name = newColor
    }
}

class Text implements IText {
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
const xMind = new MindMap()
xMind.addSheet(new Sheet())
console.log(xMind)



export { Nodee, Relationship, Position, Shape, Color, Text, Sheet, MindMap }
