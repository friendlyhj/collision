// by: youyihj
#loader contenttweaker
#priority 2499
import mods.contenttweaker.BlockState;
import scripts.collision.MultiblockElement.newElement;
import scripts.collision.MultiblockElement.MultiblockElement;

// TODO 
// BlockState => string (preinit阶段大部分方块仍未注册)
zenClass Multiblock {
    zenConstructor() {
    }

    var elements as MultiblockElement[string] = {};

    function addElement(name as string, block as BlockState, pos as int[]) as Multiblock {
        this.elements[name] = newElement(block, pos);
        return this;
    }

    function getElement(name as string) as MultiblockElement {
        return this.elements[name];
    }

    function asMap() as int[][BlockState][string] {
        var temp as int[][BlockState][string] = {};
        for name, element in this.elements {
            temp[name] = element.asMap();
        }
        return temp;
    }
}

function newMultiblock() as Multiblock {
    return Multiblock();
}