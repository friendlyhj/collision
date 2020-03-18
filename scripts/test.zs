import scripts.collision.UtilCrt.matchBlockState;

print("test!");
print(<ore:oreCopper>.firstItem.definition.id);

val test as int[][] = [
    [1,2,3],
    [4,5,6],
    [7,8,9]
];
print(test[2][1]);

//print(<blockstate:minecraft:bone_block> == <blockstate:minecraft:bone_block:axis=y>);
print(matchBlockState(<blockstate:minecraft:bone_block>, <blockstate:minecraft:bone_block:axis=y>));