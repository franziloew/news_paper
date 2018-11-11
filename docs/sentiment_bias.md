Different types of media bias - tonality bias
================
Franziska Löw
2018-11-11

To measure the tone (or sentiment) of a document adictionary-based method is applied. To conduct such an analysis, a lists of words (dictionary) associated with a given emotion, such as negativity is pre-defined by the analyst. The target text is then deconstructed into individual words (or tokens) and the frequencies of words contained in a given dictionary are then calculated.

The present paper uses a dictionary that lists words associated with positive and negative polarity weighted within the interval of \[ − 1; 1\]. [SentimentWortschatz](http://wortschatz.uni-leipzig.de/de/download), or SentiWS for short, is a publicly available German-language resource for sentiment analysis, opinion mining etc. The current version of SentiWS (v1.8b) contains 1,650 positive and 1,818 negative words, which sum up to 15,649 positive and 15,632 negative word forms incl. their inflections, respectively. It not only contains adjectives and adverbs explicitly expressing a sentiment, but also nouns and verbs implicitly containing one.

The sentiment score for each party in an article is calculated from each word that occurs in a window of two sentences before and two sentences after the occurence of that political party. An article can mention several party names, or switch tone. The given interval ensures a more reliable correlation between the political party being mentioned (the "target") and the word's polarity score, contrary to measuring all adjectives in the article. A similar approach for target identification is used in de Fortuny et al. (2012) and in Balahur et al. (2010). They latter used a 10-word window and report improved accuracy when compared to measuring all words in the article. Furthermore adjectives that score between -0.1 and +0.1 are excluded to reduce noise.

The score is then calculated from the sum of the words in a document (which can be assigned to a word from the dictionary) divided by the total number of words in that document.

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
word
</th>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;">
1
</td>
<td style="text-align: left;">
erbost
</td>
<td style="text-align: left;">
-0.3293
</td>
</tr>
<tr>
<td style="text-align: left;">
2
</td>
<td style="text-align: left;">
abbrechen
</td>
<td style="text-align: left;">
-0.3482
</td>
</tr>
<tr>
<td style="text-align: left;">
3
</td>
<td style="text-align: left;">
unzuverlässig
</td>
<td style="text-align: left;">
-0.612
</td>
</tr>
<tr>
<td style="text-align: left;">
4
</td>
<td style="text-align: left;">
beeindruckend
</td>
<td style="text-align: left;">
0.3408
</td>
</tr>
<tr>
<td style="text-align: left;">
5
</td>
<td style="text-align: left;">
degradierung
</td>
<td style="text-align: left;">
-0.3137
</td>
</tr>
<tr>
<td style="text-align: left;">
6
</td>
<td style="text-align: left;">
fragwürdig
</td>
<td style="text-align: left;">
-0.4858
</td>
</tr>
<tr>
<td style="text-align: left;">
7
</td>
<td style="text-align: left;">
instabil
</td>
<td style="text-align: left;">
-0.3352
</td>
</tr>
<tr>
<td style="text-align: left;">
8
</td>
<td style="text-align: left;">
handgemenge
</td>
<td style="text-align: left;">
-0.3174
</td>
</tr>
<tr>
<td style="text-align: left;">
9
</td>
<td style="text-align: left;">
ausbeute
</td>
<td style="text-align: left;">
-0.1894
</td>
</tr>
<tr>
<td style="border-bottom: 2px solid grey; text-align: left;">
10
</td>
<td style="border-bottom: 2px solid grey; text-align: left;">
verwerflich
</td>
<td style="border-bottom: 2px solid grey; text-align: left;">
-0.7418
</td>
</tr>
</tbody>
</table>
As with visibility bias, we then take the average party tonality in each outlet, with tonality bias computed as the deviation of each party's specific tonality from the average tonality of all parties in that outlet. To ensure comparability between visibility and tonality bias, both have been standardized to range from −1 to 1, where a party would have a bias of 0 (balanced/neutral), when its visibility or tonality is equal to the mean visibility or tonality across all parties in that media outlet.

![](../figs/sentiment.png)

![](../figs/sent_bias.png)
