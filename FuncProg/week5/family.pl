женщина(оля).
женщина(катя).
женщина(лиза).
женщина(настя).

мужчина(пётр).
мужчина(павел).
мужчина(иван).
мужчина(алексей).
мужчина(сергей).

родитель_ребёнок(алексей, настя).
родитель_ребёнок(алексей, павел).
родитель_ребёнок(алексей, оля).
родитель_ребёнок(лиза, настя).
родитель_ребёнок(лиза, павел).
родитель_ребёнок(лиза, оля).
родитель_ребёнок(пётр, сергей).
родитель_ребёнок(настя, сергей).
родитель_ребёнок(оля, иван).
родитель_ребёнок(оля, катя).

братья(Брат1, Брат2) :-
  родитель_ребёнок(Родитель, Брат1),
  родитель_ребёнок(Родитель, Брат2),
  мужчина(Брат1),
  мужчина(Брат2),
  Брат1 \= Брат2.

предок_потомок(Предок, Потомок) :-
  родитель_ребёнок(Предок, Потомок).
предок_потомок(Предок, Потомок) :-
  родитель_ребёнок(Предок, Предок1),
  предок_потомок(Предок1, Потомок).
