#ANOVA
#ANOVA-->frequency x rhythmicity 3x2
#ANOVA simple percepts (replace "simple percepts" with each scale)
anova_simple_percepts <- aov(df4$simple_percepts ~ rhythmicity * frequency, data = df4)
summary(anova_simple_percepts)
TukeyHSD(anova_simple_percepts)
#calculate partial eta
EtaSq(anova_simple_percepts)