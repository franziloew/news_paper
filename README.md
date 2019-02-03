# Comparing different types of media bias in online news

In recent years, the media and their role in the perception and decision of individuals in the political context have been increasingly subject to criticism. Terms such as "fake news" or "quality journalism" are currently part of almost every debate regarding the role of the media. Critics accuse the media of reporting biased on certain parties or political events and thus influencing the political consciousness of voters. This raises the unavoidable question of what biased reporting actually means or, on the contrary, what objective reporting is and if this is even possible. A journalist who write an article about a certain topic puts rough facts (e.g. figures on economic indicators) into a context, such that each article is shaped by the subjectivity of this journalist. Similarly, an editor of a media outlet has to select the topics to be discussed in the medium from a large pool of reports. Thus, to a certain extent, media is always filtered by journalists' perceptions and editorial decisions. 

A legitimate question, however, could be which factors or incentives lead to the selection or deselection of certain topics. On the one hand, one could assume that editors select the topics and articles that correspond to their own political views. A profit-maximizing editor, on the other hand, would tend to adapt the selection to readers' preferences. (Some populist voices would even claim that - at least the so called "mainstream media" - is controlled by the government.) 

In order to answer these and other media-related questions in the political context, quantifying the content of media is essential. In other words, what features can be used to measure the content of, for example, an online article? The literature of communication science, for example, often uses visibility (how often political actors appear in the media) or tonality (how they are evaluated) in this regard. In addition to these actor-based approaches, there are also more issue-based approaches to be found in communication science as well as in other disciplines. In this case, the contents or the language used by media are compared with the contents or the language used by political actors in order to identify whether political actors are able to place their own policy positions in the media using their own language. To estimate "ideological scores" [Groseclose & Milyo, 2005](https://www.jstor.org/stable/25098770?seq=1#metadata_info_tab_contents) count the times that a particular media outlet cites various think tanks and policy groups, and then compare this with the times that members of Congress cite the same groups. Following the same path, [Gentzkow & Shapiro, 2010](https://onlinelibrary.wiley.com/doi/abs/10.3982/ECTA7195) compare a newspaper's word choices to the word choices of Republican and Democratic members of Congress. 

In the present paper the slant-index (or ideological score) of an online newspaper is calculated by comparing the topics discussed in such newspapers with the topics discussed in parties press releases similar to [Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364). However, in contrast to [Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364) a machine learning approach is used to find the underlying topics in the text data. A structural topic model ([Roberts et al., 2013](https://scholar.princeton.edu/files/bstewart/files/stmnips2013.pdf)) is applied to identify the underlying topics in a dataset containing nearly 12.000 online news articles from seven major news provider dated from June 1, 2017 to March 1, 2018 as well as over 1.900 press releases of the parties in the german "Bundestag". As the German federal elections took place on 24th of September 2017 and the formation of the government has taken up a period of about five months, the articles considered inform their readers about both the election promises of the parties (before the election) and the coalition talks (after the election). The results of this analysis are then compared with data on the political orientation of consumers in order to evaluate whether there may be a link between consumer preferences and the slant-index of a medium.

The research contribution of this paper is twofold: First, a new method for the calculation of the slant-index is presented that allows to analyse large text data in a considerably shorter amount of time. Also, the use of computer-aided techniques allows the traceability of the analysis. Moreover, a new dataset is used for the analysis which has a current relation to the discussion about the role of media. 

The remaining course of the paper is as follows: The following section provides an overview of the related literature. Section 3 gives an introduction to the political trends within the analyzed time span (June 2017 to March 2018). The data used to conduct the model is described in section 4. Section 5 explains the generative process of the structural topic model as well as the selected parameters to run the model. The empirical analysis is conducted in section 6. 

2. Literature review

3. Background on the federal election in Germany (2017)

4. Data 
	- Press releases
	- Online newspaper articles

5. Measuring Slant (Structural topic model)

6. Emprical results
	- Agenda correlation
	- Political orientation


## 4. Data

The data analyzed in this study contains nearly 12.000 online news articles from seven major news provider dated from June 1, 2017 to March 1, 2018 as well as over [1.900 press releases]((https://franziloew.github.io/news_paper/pressReleases.html)) of the parties in the german "Bundestag". As the German federal elections took place on 24th of September 2017 and the formation of the government has taken up a period of about five months, the articles considered inform their readers about both the election promises of the parties (before the election) and the coalition talks (after the election). 

## 5. Measuring Slant

- Structural topic model

## 6. Empirical results

- Agenda correlation

[Agenda correlation](https://franziloew.github.io/news_paper/agenda.html)

![](/figs/radarchart.png)

- Political orientation

Since 2012, the [Reuters Institute Digital News Survey](http://www.digitalnewsreport.org/about-us-2018/) has been investigating the media use of digital content. Among others, the following questions are investigated: What types of news are of interest? Which devices and media are used to find them? A graphical analysis of a fraction of this data can be found [here](https://franziloew.github.io/news_paper/reuters.html). The [The Hans Bredow Institute](https://www.hans-bredow-institut.de/de/projekte/reuters-institute-digital-news-survey) has been responsible for the German part of the study.

![](/figs/reuters.png)
