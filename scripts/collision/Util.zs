// by: youyihj
#loader contenttweaker
#priority 800
import mods.contenttweaker.BlockState;
import mods.contenttweaker.BlockPos;
import mods.contenttweaker.World;
import scripts.grassUtils.EventUtilsCot as EventUtils;
import scripts.collision.Multiblock.Multiblock;

function multiblockMatcher(multiblock as Multiblock, world as World, coreWorldPos as BlockPos) as bool {
    for name, element in multiblock.asMap() {
        for block, pos in element {
            if (!matchBlockState(block, world.getBlockState(EventUtils.getOffset(coreWorldPos, pos[0], pos[1], pos[2])))) {
                return false;
            }
        }
    }
    return true;
}

function matchBlockState(state1 as BlockState, state2 as BlockState) as bool {
    return state1.block.definition.id == state2.block.definition.id;
}

function multiblockBuilder(multiblock as Multiblock, world as World, corePos as BlockPos) {
    for name, element in multiblock.asMap() {
        for block, pos in element {
            world.setBlockState(block, EventUtils.getOffset(corePos, pos[0], pos[1], pos[2]));
        }
    }
}