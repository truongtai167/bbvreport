import { Nodee, Relationship, Position, Shape, Color, Text, Sheet, MindMap } from "./xMind"

describe("xMind test", () => {
    let xMind: MindMap
    beforeEach(() => {
        xMind = new MindMap()
    })


    test('mind map should have 1 sheet when create default', () => {
        expect(xMind.sheets.length).toBe(1)
    })

    test('1 sheet should have 1 rootNode and 4 child when create default', () => {
        expect(xMind.sheets[0].rootNode).toBe(1)
        expect(xMind.sheets[0].rootNode.child).toBe(4)

    })

    test('add new sheet to the mindmap', () => {
        const newsheet = new Sheet()
        xMind.addSheet(newsheet)
        expect(xMind.sheets).toContain(newsheet)

    })

    test('remove sheet from the mindmap', () => {
        const newsheet = new Sheet()
        xMind.addSheet(newsheet)
        xMind.removeSheet(newsheet)
        expect(xMind.sheets).not.toContain(newsheet)

    })


    test('add floating node to the sheet', () => {
        const nodechild1 = new Nodee()
        xMind.sheets[0].addFloatingNode(nodechild1);
        expect(xMind.sheets[0].floatingNode).toContain(nodechild1);
    });

    test('remove floating node from the sheet', () => {
        const nodechild1 = new Nodee()
        xMind.sheets[0].addFloatingNode(nodechild1);
        xMind.sheets[0].removeFloatingNode(nodechild1);
        expect(xMind.sheets[0]).not.toContain(nodechild1);
    });

    test('rename sheet', () => {
        xMind.sheets[0].renameSheet('Sheet 1');;
        expect(xMind.sheets[0].name).toBe('Sheet 1');
    });


    test('add child to a rootNode', () => {
        const nodechild1 = new Nodee()
        xMind.sheets[0].rootNode.addChild(nodechild1);
        expect(xMind.sheets[0].rootNode.child).toContain(nodechild1);
    });
    test('remove child from a rootNode', () => {

        xMind.sheets[0].rootNode.removeChild(xMind.sheets[0].rootNode.child[0]);
        expect(xMind.sheets[0].rootNode.child.length).toBe(3)
    });

    test('change text of rootNode', () => {
        xMind.sheets[0].rootNode.changeText('xMind');
        expect(xMind.sheets[0].rootNode.text.content).toBe('xMind')
    })
    test('change color of rootNode', () => {
        xMind.sheets[0].rootNode.changeColor('red');
        expect(xMind.sheets[0].rootNode.color.name).toBe('red')
    })
    test('change shape of rootNode', () => {
        xMind.sheets[0].rootNode.changeShape('Triangle');
        expect(xMind.sheets[0].rootNode.shape.name).toBe('Triangle')
    })
    test('change text size of rootNode', () => {
        xMind.sheets[0].rootNode.changeTextSize(20)
        expect(xMind.sheets[0].rootNode.text.size).toBe(20)
    })

    test('should have relationship', () => {
        const nodechild1 = new Nodee()
        xMind.sheets[0].addRelationship(nodechild1, xMind.sheets[0].rootNode)
        expect(xMind.sheets[0].relationship).toBe(1)
    })

    test('change relationship text', () => {
        const nodechild1 = new Nodee()
        xMind.sheets[0].addRelationship(nodechild1, xMind.sheets[0].rootNode)
        xMind.sheets[0].relationship[0].changeText('abc')
        expect(xMind.sheets[0].relationship[0].text.content).toBe('abc')
    })

    test('change relationship textsize', () => {
        const nodechild1 = new Nodee()
        xMind.sheets[0].addRelationship(nodechild1, xMind.sheets[0].rootNode)
        xMind.sheets[0].relationship[0].changeTextSize(30)
        expect(xMind.sheets[0].relationship[0].text.size).toBe(30)
    })


    // test('should change the theme of rootnode and children', () => {
    //     const nodechild1 = new Nodee()
    //     rootNode.addChild(nodechild1)
    //     const theme = new Theme(new Color('Blue'), new Shape(), new Text())
    //     xMind.applyTheme(theme)
    //     expect(rootNode.color.name).toBe('Blue')
    //     expect(nodechild1.color.name).toBe('Blue')
    // })
})