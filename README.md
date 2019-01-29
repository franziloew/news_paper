# Comparing different types of media bias in online news

The importance of the internet as a source of information for political topics has grown strongly in recent years. Even though television remains the most widely used source of news in Germany (2018: 74%), numbers watching continue to decline while use of the internet for news has grown significantly in the last year (+5%, 2018: 65%) [Reuters, 2018](http://www.digitalnewsreport.org/survey/2018/germany-2018/). The expansion of the internet as a new method of communication provides a potential challenge to the primacy of the traditional media and political parties as formers of public opinion.

However, the content of mass media and its influence on voter preferences has not only been studied in the literature since the growing importance of the internet. The general hypothesis in different research disciplines is, that there is some kind of "bias" or "slant" in media and that this bias has an influence on voter opinions and preferences. The research questions that examined in the corresponding studies can be roughly divided into three main topics: (1) Is media biased?; (2) Does media bias have an effect on political outomes (e.g. elections)?; (3) What drives media bias?  

1. Is media biased?

In order to investiage these topics, it should first be determined how reporting can be quantified. In other words, how ideological or political content is measured ("slant-index", "ideological scores", ...). 

In a meta-analysis considering 59 studies from the communication literature [D'Alessio & Allen, 2006](https://academic.oup.com/joc/article/50/4/133/4110147)) found three main metrics used to study media bias: a) Visibility, b) tonality/sentiment and c) agenda (see also [Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364))

Other studies use the "language used" as metric for political content: To estimate "ideological scores" [Groseclose & Milyo, 2005](https://www.jstor.org/stable/25098770?seq=1#metadata_info_tab_contents) count the times that a particular media outlet cites various think tanks and policy groups, and then compare this with the times that members of Congress cite the same groups. Following the same path, [Gentzkow & Shapiro, 2010](https://onlinelibrary.wiley.com/doi/abs/10.3982/ECTA7195) compare a newspaper's word choices to the word choices of Republican and Democratic members of Congress.

Once the ("slant-")index has been calculated, the next step is to determine the reference point against which a possible bias is measured. 

	1. Endogenous reference point (compared to other parties) as in [Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364)

	2. Exogenous reference point: 
	- Survey values: [Junqué de Fortuny et al., 2000](https://www.sciencedirect.com/science/article/pii/S0957417412006100)
	- economic indicators: [Lott Jr. & Hassett](https://link.springer.com/article/10.1007/s11127-014-0171-5)

2. Does media bias have an effect on political outomes (e.g. elections) 

To measure an effect of one variable (media bias) on another variable (e.g. election results), there must exist a variation within the data set - for example, spatially or temporally.  
	
3. What drives media bias? 

On the demand side or on supply side.


## Data

I use a dataset of nearly 12.000 online news articles from seven major news provider dated from June 1, 2017 to March 1, 2018 to measure visibility, sentiment and agenda of the six major parties in the German Bundestag (Union (CDU/CSU), SPD, B90/Die Grünen, FDP, DIE LINKE, AfD). To measure the agenda correlation between online media and party communication, use [parties' campaign communication](https://franziloew.github.io/news_paper/pressReleases.html) ([Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364)). I use machine learning techniques to identify the underlying topics in the text corpus applying a structural topic model ([Roberts et al.](https://www.structuraltopicmodel.com/)). Furthermore, I use text-mining techniques to measure visibility and sentiment. However, I refrained from interpreting the results on a political level as much as possible, yet I demonstrate how text-mining techniques allow an efficient and objective analysis of today's on-line media landscape. 

1. [Visibility](https://franziloew.github.io/news_paper/visibility.html)

2. [Sentiment](https://franziloew.github.io/news_paper/sentiment.html)

3. [Agenda correlation](https://franziloew.github.io/news_paper/agenda.html)

After measuring the values for visibility, sentiment and agenda, I apply different reference points to estimate the potential [bias](https://franziloew.github.io/news_paper/bias.html)

The data analyzed in this study contains nearly 12.000 online news articles from seven major news provider dated from June 1, 2017 to March 1, 2018 as well as over 1.900 press releases of the parties in the german "Bundestag". As the German federal elections took place on 24th of September 2017 and the formation of the government has taken up a period of about five months, the articles considered inform their readers about both the election promises of the parties (before the election) and the coalition talks (after the election). 

Anonther interesting question is, if the reporting of media corresponds to the political tendencies of its consumers. Since 2012, the [Reuters Institute Digital News Survey](http://www.digitalnewsreport.org/about-us-2018/) has been investigating the media use of digital content. Among others, the following questions are investigated: What types of news are of interest? Which devices and media are used to find them? A graphical analysis of a fraction of this data can be found [here](https://franziloew.github.io/news_paper/reuters.html). The [The Hans Bredow Institute](https://www.hans-bredow-institut.de/de/projekte/reuters-institute-digital-news-survey) has been responsible for the German part of the study.

![](/figs/reuters.png)
