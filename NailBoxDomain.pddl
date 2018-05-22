(define
    (domain NailBoxDomain)
    (:requirements :strips :negative-preconditions :equality)
    (:predicates
        (clear ?x)
        (on-table ?x)
        (free-arm)
        (holding ?x)
        (on ?x ?y)
        (hammered ?x ?y ?z)
    )

    ;con object1 si intende l'oggetto in superficie
    ;con object2 quello immediatamente sotto object1
    ;con object3 quello immediatamente sotto object2


    (:action get-from-table
        :parameters (?object1)

        ;per poter fare la get-from-table è necessario che:
            ;il braccio sia libero
            ;l'oggetto1 sia sul tavolo
            ;l'oggetto1 si possa prendere
        :precondition (and
                        (free-arm)
                        (on-table ?object1)
                        (clear ?object1)
                    )

        ;gli effetti della get-from-table sono:
            ;il braccio diviene occupato, ha preso l'oggetto1
            ;l'oggetto1 non è più sul tavolo
            ;l'oggetto1 non è più prendibile
            ;il braccio non è più libero
        :effect (and
                    (holding ?object1)
                    (not
                        (on-table ?object1)
                    )
                    (not
                        (clear ?object1)
                    )
                    (not
                        (free-arm)
                    )
                )
    )


    (:action put-on-table
        :parameters  (?object1)

        ;per poter fare la put-on-table è necessario che:
            ;il braccio abbia un oggetto in mano
        :precondition (and
                        (holding ?object1)
                    )

        ;gli effetti della put-on-table sono:
            ;l'oggetto1 torna sul tavolo
            ;il braccio non ha più in mano l'oggetto1
            ;l'oggetto1 torna prendibile
            ;il braccio torna libero
        :effect (and
                    (on-table ?object1)
                    (not
                        (holding ?object1)
                    )
                    (clear ?object1)
                    (free-arm)
                )
    )

    (:action stack
        :parameters  (?object1 ?object2)

        ;la stack permette di impilare un oggetto sopra ad un altro. Per poterla fare è necessario che:
            ;il braccio abbia in mano l'oggetto1
            ;l'oggetto2 non abbia altri oggetti sopra (per potervi quindi impilare l'oggetto1)
        :precondition (and
                        (holding ?object1)
                        (clear ?object2)
                    )

        ;gli effetti della stack sono:
            ;il braccio torna libero
            ;l'oggetto2 non è più prendibile
            ;il braccio non ha più in mano l'oggetto1
            ;l'oggetto1 torna prendibile
            ;l'oggetto1 è impilato sull'oggetto2
        :effect (and
                    (free-arm)
                    (not
                        (clear ?object2)
                    )
                    (not
                        (holding ?object1)
                    )
                    (clear ?object1)
                    (on ?object1 ?object2)
                )
    )

    (:action unstack
        :parameters  (?object1 ?object2)

        ;La unstack permette di prendere un oggetto che si trova impilato sopra ad un altro. Per poterla fare è necessario che:
            ;l'oggetto1 sia effettivamente impilato sopra l'oggetto2
            ;il braccio sia libero
            ;l'oggetto1 sia prendibile
        :precondition (and
                        (on ?object1 ?object2)
                        (free-arm)
                        (clear ?object1)
                    )

        ;gli effetti della stack sono:
            ;l'oggetto1 non è più impilato sull'oggetto2
            ;il braccio non è più libero
            ;il braccio ha in mano l'oggetto1
            ;l'oggetto2 torna prendibile
            ;l'oggetto1 non è più prendibile
        :effect (and
                    (not
                        (on ?object1 ?object2)
                    )
                    (not
                        (free-arm)
                    )
                    (holding ?object1)
                    (clear ?object2)
                    (not
                        (clear ?object1)
                    )
                )
    )

    (:action hammering
        :parameters  (?object1 ?object2 ?object3)

        ;la hammering permette di unire 3 oggetti in uno solo. Per poterla fare è necessario che:
            ;l'oggetto1 sia prendibile e contemporaneamente non sul tavolo
            ;l'oggetto2 non sia sul tavolo
            ;l'oggetto2 e l'oggetto3 non siano prendibili
            ;l'oggetto3 sia sul tavolo
            ;il braccio sia libero
        :precondition (and
                        (clear ?object1)
                        (not
                            (on-table ?object1)
                        )
                        (not
                            (on-table ?object2)
                        )
                        (not
                            (clear ?object2)
                        )
                        (not
                            (clear ?object3)
                        )
                        (on-table ?object3)
                        (free-arm)
                    )

        ;gli effetti della hammering sono:
            ;l'oggetto1, l'oggetto2, l'oggetto3 d'ora in poi non saranno più prendibili separatamente
            ;i 3 oggetti vengono trattati come un unico oggetto hammered
        :effect (and
                    (hammered ?object1 ?object2 ?object3)
                    (not
                        (clear ?object1)
                    )
                    (not
                        (clear ?object2)
                    )
                    (not
                        (clear ?object3)
                    )
                )
    )
)
