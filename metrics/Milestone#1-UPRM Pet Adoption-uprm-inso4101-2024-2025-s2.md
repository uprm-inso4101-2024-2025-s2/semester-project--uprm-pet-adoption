# Milestone Data

## Date Generated: 2025-03-15
| Developer | Points Closed | Percent Contribution | Projected Grade | Lecture Topic Tasks |
| --------- | ------------- | -------------------- | --------------- | ------------------- |
| Total | 0.0 | /100% | /100% | 0 |


## Sprint Task Completion

| Developer | Sprint 1<br>2025/01/27, 08:00 AM<br>2025/02/09, 02:00 AM | Sprint 2<br>2025/02/09, 02:00 AM<br>2025/02/21, 08:00 PM |
|---|---|---|

## Weekly Discussion Participation

| Developer | Week #1 | Week #2 | Week #3 | Week #4 | Penalty |
|---|---|---|---|---|---|

## Point Percent by Label

# Metrics Generation Logs

| Message |
| ------- |
| WARNING: list index out of range |
| INFO: Found Project(name='UPRM Pet Adoption', number=2, url='https://github.com/orgs/uprm-inso4101-2024-2025-s2/projects/2', public=True) |
| ERROR: list index out of range |
| Traceback (most recent call last): |
|   File "/home/runner/work/semester-project--uprm-pet-adoption/semester-project--uprm-pet-adoption/inso-gh-query-metrics/src/generateMilestoneMetricsForActions.py", line 87, in generateMetricsFromV2Config |
|     discussions=getDiscussions(org=organization, team=team), |
|                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ |
|   File "/home/runner/work/semester-project--uprm-pet-adoption/semester-project--uprm-pet-adoption/inso-gh-query-metrics/src/utils/discussions.py", line 184, in getDiscussions |
|     return [ |
|            ^ |
|   File "/home/runner/work/semester-project--uprm-pet-adoption/semester-project--uprm-pet-adoption/inso-gh-query-metrics/src/utils/discussions.py", line 184, in <listcomp> |
|     return [ |
|            ^ |
|   File "/home/runner/work/semester-project--uprm-pet-adoption/semester-project--uprm-pet-adoption/inso-gh-query-metrics/src/utils/discussions.py", line 146, in getDiscussionDicts |
|     discussion_info: dict = response["organization"]["teams"]["nodes"][0][ |
|                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^ |
| IndexError: list index out of range |
