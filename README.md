# Comparing different types of media bias in online news

The importance of the internet as a source of information for political topics has grown strongly in recent years. Even though television remains the most widely used source of news in Germany (2018: 74%), numbers watching continue to decline while use of the internet for news has grown significantly in the last year (+5%, 2018: 65%) [Reuters, 2018](http://www.digitalnewsreport.org/survey/2018/germany-2018/). The expansion of the internet as a new method of communication provides a potential challenge to the primacy of the traditional media and political parties as formers of public opinion.

However, the influence of media reporting on voter preferences has not only been studied in the literature since the growing importance of the internet. The general hypothesis is that reporting in political news may have a profound influence on voter opinions and preferences. It can therefore be argued, that one central responsibility of the media is to supply voters with balanced and objective information on relevant political issues and actors.

The opposite of a balanced reporting is a biased on. A large number of studies have investigated the influence of such bias on voter preferences. An important factor in conducting such research is the concept of the bias and the reference point against which the bias is measured. The latter can, depending on the research question, be based on the current standing in polls. Another possibility is to use the average values of the other parties as a reference value. 

The concept of media bias encompasses different subtypes: (1) Visibility bias, (2) tonality bias and (3) agenda bias. These three concepts measure how often political actors appear in the media (visibility bias), how they are evaluated (tonality bias) and whether they are able to present their own political positions and talk about their issues in the media (agenda bias). The latter therefore stems from a journalist's or editor's decision to select or ignore specific news stories. Most of the literature on media bias focuses on one type of bias and most research tends to disregard agenda bias as the operationalization is somewhat more challenging. In order to know which news stories have been selected as well as deselected by journalists, one would have to know the universe of news stories at a given point in time. 

I adopt the approach used in [Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364) in using [parties' campaign communication](https://franziloew.github.io/news_paper/pressReleases.html) as an approximation of the potential universe of news stories. The present analysis differs from earlier approaches in that I use machine learning techniques to identify the underlying topics in the text corpus applying a structural topic model ([Roberts et al.](https://www.structuraltopicmodel.com/)). Furthermore, I use text-mining techniques to measure coverage and tonality bias. However, I refrained from interpreting the results on a political level as much as possible, yet I demonstrate how text-mining techniques allow an efficient and objective analysis of today's on-line media landscape. 

The data analyzed in this study contains nearly 12.000 online news articles from seven major news provider dated from June 1, 2017 to March 1, 2018 as well as over 1.900 press releases of the parties in the german "Bundestag". As the German federal elections took place on 24th of September 2017 and the formation of the government has taken up a period of about five months, the articles considered inform their readers about both the election promises of the parties (before the election) and the coalition talks (after the election). 

[Bias measures](https://franziloew.github.io/news_paper/bias.html)

1. [Visibility](https://franziloew.github.io/news_paper/visibility.html)
![](/figs/vis_bias.png)

2. [Sentiment](https://franziloew.github.io/news_paper/sentiment.html)
![](/figs/sent_bias.png)

3. [Agenda correlation](https://franziloew.github.io/news_paper/agenda.html)
![](/figs/agenda_bias.png)


Anonther interesting question is, if the reporting of media corresponds to the political tendencies of its consumers. Since 2012, the [Reuters Institute Digital News Survey](http://www.digitalnewsreport.org/about-us-2018/) has been investigating the media use of digital content. Among others, the following questions are investigated: What types of news are of interest? Which devices and media are used to find them? A graphical analysis of a fraction of this data can be found [here](https://franziloew.github.io/news_paper/reuters.html). The [The Hans Bredow Institute](https://www.hans-bredow-institut.de/de/projekte/reuters-institute-digital-news-survey) has been responsible for the German part of the study.

![](/figs/reuters.png)
