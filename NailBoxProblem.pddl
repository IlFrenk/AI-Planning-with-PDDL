(define
    (problem NailBoxProblem)
    (:domain NailBoxDomain)
    (:objects a b c)
    (:init
        (on-table c)
        (on-table b)
        (on a b)
        (clear a)
        (clear c)
        (free-arm)
    )
    (:goal
        (and
            (hammered a b c)
        )
    )
)
