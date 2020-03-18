// by: youyihj
#loader contenttweaker
import mods.contenttweaker.BlockState;
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
import mods.contenttweaker.ActionResult;

val iii as Item = VanillaFactory.createItem("iii");
iii.onItemUse = function(player, world, pos, hand, facing, blockHit) {
    if (world.remote) {
        val ddd as BlockState[] = [
            <block:thermalfoundation:ore:4>,
            <block:contenttweaker:wither_altar>,
            <block:minecraft:iron_block>
        ];

        for aa in ddd {
            print(isNull(aa));
            print(aa.block.definition.id);
            print(aa.block.meta);
        }
    }
    return ActionResult.success();
};
iii.register();