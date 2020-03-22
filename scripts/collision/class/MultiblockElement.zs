// by: youyihj
#loader contenttweaker
#priority 2500
import mods.contenttweaker.BlockState;

// TODO 
// BlockState => string (preinit阶段大部分方块仍未注册)
zenClass MultiblockElement {
    val block as BlockState;
    val pos as int[];
    zenConstructor(blockArg as BlockState, posArg as int[]) {
        block = blockArg;
        pos = posArg;
    }

    function asMap() as int[][BlockState] {
        var temp as int[][BlockState] = {};
        temp[this.block] = this.pos;
        return temp;
    }
}

function newElement(block as BlockState, pos as int[]) as MultiblockElement {
    return MultiblockElement(block, pos);
}
