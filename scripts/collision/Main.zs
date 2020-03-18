// by: youyihj
#priority 250
#loader contenttweaker
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Block;
import mods.contenttweaker.Item;
import mods.contenttweaker.CreativeTab;
import mods.contenttweaker.Fluid;
import mods.contenttweaker.Color;
import mods.contenttweaker.BlockMaterial;
import mods.contenttweaker.SoundType;
import mods.contenttweaker.SoundEvent;
import crafttweaker.creativetabs.ICreativeTab;
import crafttweaker.data.IData;
import mods.contenttweaker.BlockPos;
import mods.contenttweaker.BlockState;
import mods.contenttweaker.ActionResult;
import mods.ctutils.utils.Math;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import mods.contenttweaker.World;
import mods.contenttweaker.Facing;
import mods.ctutils.world.IExplosion;
import mods.contenttweaker.Player;
import crafttweaker.world.IFacing;
import scripts.grassUtils.CotUtils;
import scripts.grassUtils.EventUtilsCot;

CotUtils.addBlock("proton", <blockmaterial:rock>, 1.0f, 40, <soundtype:stone>, 12, false, "pickaxe", 0);
CotUtils.addBlock("neutron", <blockmaterial:rock>, 1.0f, 40, <soundtype:stone>, 12, false, "pickaxe", 0);
CotUtils.addBlock("collider_lv1", <blockmaterial:iron>, 3.0f, 120, <soundtype:metal>, 0, false, "pickaxe", 0);
CotUtils.addBlock("collider_lv2", <blockmaterial:iron>, 3.0f, 120, <soundtype:metal>, 0, false, "pickaxe", 0);
CotUtils.addBlock("collider_lv3", <blockmaterial:iron>, 3.0f, 120, <soundtype:metal>, 0, false, "pickaxe", 1);
CotUtils.addBlock("collider_lv4", <blockmaterial:iron>, 3.0f, 120, <soundtype:metal>, 0, false, "pickaxe", 2);
CotUtils.addBlock("plank_wood", <blockmaterial:wood>, 2.0f, 40, <soundtype:wood>, 0, false, "axe", 0);
CotUtils.addBlock("proton_empty_refined", <blockmaterial:rock>, 2.5f, 40, <soundtype:stone>, 0, false, "pickaxe", 1);
CotUtils.addBlock("neutron_empty_refined", <blockmaterial:rock>, 2.5f, 40, <soundtype:stone>, 0, false, "pickaxe", 1);
CotUtils.addBlock("proton_refined", <blockmaterial:rock>, 2.5f, 40, <soundtype:stone>, 0, false, "pickaxe", 1);
CotUtils.addBlock("neutron_refined", <blockmaterial:rock>, 2.5f, 40, <soundtype:stone>, 0, false, "pickaxe", 1);
CotUtils.addNormalItem("metal_chunk");
CotUtils.addNormalItem("mystical_gem");
CotUtils.addNormalItem("little_ghast_drop");
CotUtils.addNormalItem("wither_skull_piece");

val proton as Block = VanillaFactory.createBlock("proton_empty", <blockmaterial:rock>);
proton.blockHardness = 1.0f;
proton.setBlockSoundType(<soundtype:stone>);
proton.setToolClass("pickaxe");
proton.setToolLevel(0);
proton.onRandomTick = function(world, blockPos, blockState){
    if (!world.remote && world.canSeeSky(blockPos.getOffset("up", 1)) && world.dayTime && world.getRandom().nextBoolean()) {
        world.setBlockState(<block:contenttweaker:proton>, blockPos);
    }
};
proton.register();

val neutron as Block = VanillaFactory.createBlock("neutron_empty", <blockmaterial:rock>);
neutron.blockHardness = 1.0f;
neutron.setBlockSoundType(<soundtype:stone>);
neutron.setToolClass("pickaxe");
neutron.setToolLevel(0);
neutron.onRandomTick = function(world, blockPos, blockState){
    if (!world.remote && world.canSeeSky(blockPos.getOffset("up", 1)) && world.dayTime && world.getRandom().nextBoolean()) {
        world.setBlockState(<block:contenttweaker:neutron>, blockPos);
    }
};
neutron.register();

function wandFunction(world as World, pos as BlockPos, lib as byte[][][IItemStack], player as Player, pnArray as BlockState[], pnEmptyArray as BlockState[]) as ActionResult {
    for x in 0 .. 3 {
        for z in 0 .. 3 {
            var posOffset as BlockPos = EventUtilsCot.getOffset(pos, x - 1, 0, z - 1);
            var stateOffset as BlockState = world.getBlockState(posOffset);
            if (stateOffset == pnEmptyArray[0] || stateOffset == pnEmptyArray[1]) {
                world.setBlockState(<block:minecraft:air>, posOffset);
                print("Clear!");
            }
        }
    }
    if (!world.remote) {
        world.newExplosion(player, pos.x, pos.y, pos.z, 0.1f, false, false);
        val air as BlockState = <block:minecraft:air>;
        val moduleArray as BlockState[] = [
            air, 
            pnArray[0],
            pnArray[1]
        ];
        var blockSurround as BlockState[][] = [
            [air,air,air],
            [air,air,air],
            [air,air,air]
        ];
        for x in 0 .. 3 {
            for z in 0 .. 3 {
                var posOffset as BlockPos = EventUtilsCot.getOffset(pos, x - 1, 0, z - 1);
                var stateOffset as BlockState = world.getBlockState(posOffset);
                if (!(x == 1 && z == 1)) {
                    blockSurround[x][z] = stateOffset;
                }
            } 
        }
        for key, value in lib {
            var craftable as bool = true;
            for x in 0 .. 3 {
                for z in 0 .. 3 {
                    if (craftable) {
                        craftable &= (blockSurround[x][z] == moduleArray[value[x][z]]);
                    }
                }
            }
            if (craftable) { // 载体满足某个合成的条件
                var posSpawnItem as BlockPos = pos;
                while (!world.canSeeSky(posSpawnItem)) {
                    posSpawnItem = posSpawnItem.getOffset("up", 1);
                }
                EventUtilsCot.spawnItem(world, key, posSpawnItem);
                for x, zs in value {
                    for z, code in zs {
                        if (code == 1) {
                            world.setBlockState(pnEmptyArray[0], EventUtilsCot.getOffset(pos, x - 1, 0, z - 1));
                        } else if (code == 2) {
                            world.setBlockState(pnEmptyArray[1], EventUtilsCot.getOffset(pos, x - 1, 0, z - 1));
                        }
                    }
                }
                return ActionResult.success();
            }
        }
        return ActionResult.pass();
    } else {
        return ActionResult.success();
    }
}

val wand as Item = VanillaFactory.createItem("collider_starter");
wand.maxStackSize = 1;
wand.onItemUse = function(player, world, pos, hand, facing, blockHit) {
    if (world.getBlockState(pos) == <block:contenttweaker:collider_lv1>) {
        return wandFunction(world, pos, scripts.collision.ColliderRecipes.colliderRecipesOne, player,
        [<block:contenttweaker:proton>, <block:contenttweaker:neutron>], [<block:contenttweaker:proton_empty>, <block:contenttweaker:neutron_empty>]);
    }
    if (world.getBlockState(pos) == <block:contenttweaker:collider_lv2>) {
        return wandFunction(world, pos, scripts.collision.ColliderRecipes.colliderRecipesTwo, player,
        [<block:contenttweaker:proton>, <block:contenttweaker:neutron>], [<block:contenttweaker:proton_empty>, <block:contenttweaker:neutron_empty>]);
    }
    if (world.getBlockState(pos) == <block:contenttweaker:collider_lv3>) {
        return wandFunction(world, pos, scripts.collision.ColliderRecipes.colliderRecipesThree, player,
        [<block:contenttweaker:proton_refined>, <block:contenttweaker:neutron_refined>], [<block:contenttweaker:proton_empty_refined>, <block:contenttweaker:neutron_empty_refined>]);
    }
    if (world.getBlockState(pos) == <block:contenttweaker:collider_lv4>) {
        return wandFunction(world, pos, scripts.collision.ColliderRecipes.colliderRecipesFour, player,
        [<block:contenttweaker:proton_refined>, <block:contenttweaker:neutron_refined>], [<block:contenttweaker:proton_empty_refined>, <block:contenttweaker:neutron_empty_refined>]);
    }
    return ActionResult.pass();
};
wand.register();

val water as Item = VanillaFactory.createItem("water_drop");
water.maxStackSize = 1;
water.onItemUse = function(player, world, pos, hand, facing, blockHit) {
    if (world.getBlockState(pos.getOffset(facing, 1)) == <block:minecraft:air>) {
        if (!world.remote) {
            world.setBlockState(<block:minecraft:water>, pos.getOffset(facing, 1));
            player.getHeldItem(hand).shrink(1);
        }
        return ActionResult.success();
    }
    return ActionResult.pass();
};
water.register();

val lava as Item = VanillaFactory.createItem("lava_drop");
lava.maxStackSize = 1;
lava.onItemUse = function(player, world, pos, hand, facing, blockHit) {
    if (world.getBlockState(pos.getOffset(facing, 1)) == <block:minecraft:air>) {
        if (!world.remote) {
            world.setBlockState(<block:minecraft:lava>, pos.getOffset(facing, 1));
            player.getHeldItem(hand).shrink(1);
        }
        return ActionResult.success();
    }
    return ActionResult.pass();
};
lava.register();