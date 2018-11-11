# Comparing different types of media bias in online news

![](/figs/bias.png)

The importance of the internet as a source of information for political topics has grown strongly in recent years. Even though television remains the most widely used source of news in Germany (2018: 74%), numbers watching continue to decline while use of the internet for news has grown significantly in the last year (+5%, 2018: 65%) [Reuters, 2018](http://www.digitalnewsreport.org/survey/2018/germany-2018/). The expansion of the internet as a new method of communication provides a potential challenge to the primacy of the traditional media and political parties as formers of public opinion.

However, the influence of media bias on voter preferences has not only been studied in the literature since the growing importance of the internet. The general hypothesis is that bias in political news may have a profound influence on voter opinions and preferences. It can therefore be argued, that one central responsibility of the media is to supply voters with balanced and objective information on relevant political issues and actors.

The concept of media bias encompasses different subtypes: (1) Visibility bias, (2) tonality bias and (3) agenda bias. These three concepts measure how often political actors appear in the media (visibility bias), how they are evaluated (tonality bias) and whether they are able to present their own political positions and talk about their issues in the media (agenda bias). The latter therefore stems from a journalist's or editor's decision to select or ignore specific news stories. Most of the literature on media bias focuses on one type of bias and most research tends to disregard agenda bias as the operationalization is somewhat more challenging. In order to know which news stories have been selected as well as deselected by journalists, one would have to know the universe of news stories at a given point in time. I adopt the approach used in [Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364) in using parties' campaign communication as an approximation of the potential universe of news stories. The present analysis differs from earlier approaches in that I use machine learning techniques to identify the underlying topics in the text corpus applying a structural topic model ([Roberts et al.](https://www.structuraltopicmodel.com/)). Furthermore, I use text-mining techniques to measure coverage and tonality bias. However, I refrained from interpreting the results on a political level as much as possible, yet I demonstrate how text-mining techniques allow an efficient and objective analysis of today's on-line media landscape. 

The data analyzed in this study contains nearly 12.000 online news articles from seven major news provider dated from June 1, 2017 to March 1, 2018 as well as over 1.900 press releases of the parties in the german "Bundestag". As the German federal elections took place on 24th of September 2017 and the formation of the government has taken up a period of about five months, the articles considered inform their readers about both the election promises of the parties (before the election) and the coalition talks (after the election). 


![](/figs/article_timeline.png)


## Bias measures

1. [Visibility Bias](https://franziloew.github.io/news_paper/visibility_bias.html)

2. [Tonality Bias](https://franziloew.github.io/news_paper/sentiment_bias.html)

3. [Agenda Bias](https://franziloew.github.io/news_paper/agendaBias.html)

The different results underline the importance of studying different types of media biases simultaneously, as examining just one aspect provides a misleading picture of the extent and nature of bias. The existence of various and diverse forms of media bias also means that it is worth considering their distinct effects on party preferences.
