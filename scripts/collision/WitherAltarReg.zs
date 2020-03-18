// by: youyihj
#loader contenttweaker
#priority 230
import mods.contenttweaker.World;
import mods.contenttweaker.BlockPos;
import mods.contenttweaker.BlockState;
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
import mods.contenttweaker.Hand;
import mods.contenttweaker.ActionResult;
import crafttweaker.entity.IEntityEquipmentSlot;

import scripts.grassUtils.CotUtils;
import scripts.collision.Util;
import scripts.collision.Multiblock.Multiblock;
import scripts.collision.Multiblock.newMultiblock;

CotUtils.addBlock("wither_altar", <blockmaterial:iron>, 3.0f, 120, <soundtype:metal>, 0, false, "pickaxe", 2);

/* static bone as BlockState = <block:minecraft:bone_block>;
static witherAltar as Multiblock = newMultiblock()
.addElement("core", <block:contenttweaker:wither_altar>, [0,0,0])
.addElement("one", bone, [1,0,0])
.addElement("two", bone, [-1,0,0])
.addElement("three", bone, [0,0,-1])
.addElement("four", bone, [0,0,1]);
for i in 0 .. 3 {
    for j in 0 .. 3 {
        witherAltar.addElement("bottom" ~ i ~ j, bone, [i - 1, -1, j - 1]);
    }
} */

val witherAltarWand as Item = VanillaFactory.createItem("wither_altar_wand");
witherAltarWand.maxStackSize = 1;
witherAltarWand.onItemUse = function(player, world, pos, hand, facing, blockHit) {
    val bone as BlockState = <block:minecraft:bone_block>;
    val witherAltar as Multiblock = newMultiblock()
    .addElement("core", <block:contenttweaker:wither_altar>, [0,0,0])
    .addElement("one", bone, [1,0,0])
    .addElement("two", bone, [-1,0,0])
    .addElement("three", bone, [0,0,-1])
    .addElement("four", bone, [0,0,1]);
    for i in 0 .. 3 {
        for j in 0 .. 3 {
            witherAltar.addElement("bottom" ~ i ~ j, bone, [i - 1, -1, j - 1]);
        }
    }
    if (!world.remote && Util.multiblockMatcher(witherAltar, world, pos) && hand == Hand.main()) {
        val main as IEntityEquipmentSlot = IEntityEquipmentSlot.mainHand();
        player.setItemToSlot(main, player.getHeldItem(hand).updateTag({AltarPosX : pos.x, AltarPosY : pos.y, AltarPosZ : pos.z, AltarWorld : world.dimension}));
        player.sendStatusMessage("结构正确！保存祭坛坐标！", true);
        return ActionResult.success();
    }
    return ActionResult.pass();
};
witherAltarWand.register();

val debugger as Item = VanillaFactory.createItem("debugger");
debugger.onItemUse = function(player, world, pos, hand, facing, blockHit) {
    if (!world.remote) {
        val state as BlockState = world.getBlockState(pos);
        player.sendMessage(state.block.definition.id);
        player.sendMessage(state.block.meta);
        if (!isNull(state.block.data)) {
            player.sendMessage(state.block.data.asString());
        }
    }
    return ActionResult.success();
};
debugger.register();

