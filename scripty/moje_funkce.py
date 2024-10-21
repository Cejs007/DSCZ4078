from random import randint


def mortal_combat(postava_1, postava_2):
    """
    Vezme 2 objekty typu Postava a nechá je bojovat proti sobě.
    Vrací jméno vítěze!
    """
    # dokud někdo neumře -> and znamená oba zároveň nejsou mrtví
    while not postava_1.mrtev and not postava_2.mrtev:
        # hodím si mincí -> 0 - False, 1 - True
        if randint(0, 1):
            postava_1.obrana(postava_2.utok())
        else:
            postava_2.obrana(postava_1.utok())

    # rozpoznání kdo vlastně vyhrál
    if postava_1.mrtev:
        return postava_2.jmeno
    else:
        return postava_1.jmeno
