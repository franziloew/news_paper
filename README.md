# Comparing different types of media bias in online news

The importance of the internet as a source of information for political topics has grown strongly in recent years. Even though television remains the most widely used source of news in Germany (2018: 74%), numbers watching continue to decline while use of the internet for news has grown significantly in the last year (+5%, 2018: 65%) [Reuters, 2018](http://www.digitalnewsreport.org/survey/2018/germany-2018/). The expansion of the internet as a new method of communication provides a potential challenge to the primacy of the traditional media and political parties as formers of public opinion.

However, the influence of media reporting on voter preferences has not only been studied in the literature since the growing importance of the internet. The general hypothesis is that reporting in political news may have a profound influence on voter opinions and preferences. It can therefore be argued, that one central responsibility of the media is to supply voters with balanced and objective information on relevant political issues and actors.

The opposite of a balanced reporting is a biased on. A large number of studies have investigated the influence of such bias on voter preferences. An important factor in conducting such research is the concept of the bias and the reference point against which the bias is measured. The latter can, depending on the research question, be based on the current standing in polls. Another possibility is to use the average values of the other parties as a reference value. 

In their meta study in communication research [D'Alessio & Allen, 2006](https://academic.oup.com/joc/article/50/4/133/4110147) the concept of media bias encompasses different subtypes: (1) Visibility bias, (2) tonality bias and (3) agenda bias. These three concepts measure how often political actors appear in the media (visibility bias), how they are evaluated (tonality bias) and whether they are able to present their own political positions and talk about their issues in the media (agenda bias). The latter therefore stems from a journalist's or editor's decision to select or ignore specific news stories. 

Another differentiation can be made according to the reference point to measure the bias. 

1. Endogenous reference point (compared to other parties) as in [Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364)

2. Exogenous reference point: 
	- Survey values: [Junqué de Fortuny et al., 2000](https://www.sciencedirect.com/science/article/pii/S0957417412006100)
	- language used by politicans: [Gentzkow & Shapiro, 2010](https://onlinelibrary.wiley.com/doi/abs/10.3982/ECTA7195)
	- economic indicators: [Lott Jr. & Hassett](https://link.springer.com/article/10.1007/s11127-014-0171-5)
	- citated think tanks: [Groseclose & Milyo, 2005](https://www.jstor.org/stable/25098770?seq=1#metadata_info_tab_contents))

I use a dataset of nearly 12.000 online news articles from seven major news provider dated from June 1, 2017 to March 1, 2018 to measure visibility, sentiment and agenda of the six major parties in the German Bundestag (Union (CDU/CSU), SPD, B90/Die Grünen, FDP, DIE LINKE, AfD). To measure the agenda correlation between online media and party communication, use [parties' campaign communication](https://franziloew.github.io/news_paper/pressReleases.html) ([Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364)). I use machine learning techniques to identify the underlying topics in the text corpus applying a structural topic model ([Roberts et al.](https://www.structuraltopicmodel.com/)). Furthermore, I use text-mining techniques to measure visibility and sentiment. However, I refrained from interpreting the results on a political level as much as possible, yet I demonstrate how text-mining techniques allow an efficient and objective analysis of today's on-line media landscape. 

1. [Visibility](https://franziloew.github.io/news_paper/visibility.html)
![](/figs/vis_bias.png)

2. [Sentiment](https://franziloew.github.io/news_paper/sentiment.html)
![](/figs/sent_bias.png)

3. [Agenda correlation](https://franziloew.github.io/news_paper/agenda.html)
![](/figs/agenda_bias.png)

After measuring the values for visibility, sentiment and agenda, I apply different reference points to estimate the potential [bias](https://franziloew.github.io/news_paper/bias.html)


The data analyzed in this study contains nearly 12.000 online news articles from seven major news provider dated from June 1, 2017 to March 1, 2018 as well as over 1.900 press releases of the parties in the german "Bundestag". As the German federal elections took place on 24th of September 2017 and the formation of the government has taken up a period of about five months, the articles considered inform their readers about both the election promises of the parties (before the election) and the coalition talks (after the election). 

Anonther interesting question is, if the reporting of media corresponds to the political tendencies of its consumers. Since 2012, the [Reuters Institute Digital News Survey](http://www.digitalnewsreport.org/about-us-2018/) has been investigating the media use of digital content. Among others, the following questions are investigated: What types of news are of interest? Which devices and media are used to find them? A graphical analysis of a fraction of this data can be found [here](https://franziloew.github.io/news_paper/reuters.html). The [The Hans Bredow Institute](https://www.hans-bredow-institut.de/de/projekte/reuters-institute-digital-news-survey) has been responsible for the German part of the study.

![](/figs/reuters.png)
