import { Nodee, Relationship, Position, Shape, Color, Text, MindMap } from "./xMind"

describe("xMind test", () => {
    let rootNode: Nodee
    let xMind: MindMap
    beforeEach(() => {
        rootNode = new Nodee()
        rootNode.shape = new Shape()
        rootNode.text = new Text()
        rootNode.position = new Position(0, 0)
        rootNode.color = new Color('Black')
        rootNode.child = []
        xMind = new MindMap(rootNode)
    })
    test('add new node to the mind map', () => {
        const nodechild1 = new Nodee()
        xMind.addNode(nodechild1);
        expect(xMind.otherNode).toContain(nodechild1);
    });
    test('remove new node from the mind map', () => {

        const nodechild1 = new Nodee()
        xMind.addNode(nodechild1);
        xMind.removeNode(nodechild1);
        expect(xMind.otherNode).not.toContain(nodechild1);
    });
    test('add child to a node', () => {

        const nodechild1 = new Nodee()
        rootNode.addChild(nodechild1);
        expect(rootNode.child).toContain(nodechild1);
    });
    test('remove child from a node', () => {

        const nodechild1 = new Nodee()
        rootNode.addChild(nodechild1);
        rootNode.removeChild(nodechild1);
        expect(rootNode.child).not.toContain(nodechild1);
    });

    test('change text', () => {
        rootNode.changeText('xMind');
        expect(rootNode.text.content).toBe('xMind')
    })
    test('change color xmind node', () => {
        rootNode.changeColor('red');
        expect(rootNode.color.name).toBe('red')
    })
    test('change shape', () => {
        rootNode.changeShape('Triangle');
        expect(rootNode.shape.name).toBe('Triangle')
    })
    test('change text size', () => {
        rootNode.changeTextSize(20)
        expect(rootNode.text.size).toBe(20)
    })
    test('add ', () => {
        rootNode.changeTextSize(20)
        expect(rootNode.text.size).toBe(20)
    })

    test('should have relationship', () => {
        const nodechild1 = new Nodee()
        xMind.addRelationship(nodechild1, rootNode)
        expect(xMind.relationship.length).toBe(1)
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