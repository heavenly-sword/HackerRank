-- Based on https://nifannn.github.io/2017/10/24/SQL-Notes-Hackerrank-Interviews/
/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
SELECT C.contest_id, C.hacker_id, C.name, SUM(total_submissions), SUM(total_accepted_submissions), SUM(total_views), SUM(total_unique_views)
FROM Contests C INNER JOIN Colleges Col ON C.contest_id = Col.contest_id
INNER JOIN Challenges Cha ON Cha.college_id = Col.college_id
LEFT JOIN 
(
    SELECT challenge_id, SUM(total_views) AS total_views, SUM(total_unique_views) AS total_unique_views
    FROM View_Stats
    GROUP BY challenge_id
) V ON V.challenge_id = Cha.challenge_id
LEFT JOIN 
(
    SELECT challenge_id, SUM(total_submissions) AS total_submissions, SUM(total_accepted_submissions) AS total_accepted_submissions
    FROM Submission_Stats
    GROUP BY challenge_id
)S ON S.challenge_id = Cha.challenge_id
GROUP BY C.contest_id, C.hacker_id, C.name
HAVING SUM(total_submissions) + SUM(total_accepted_submissions) + SUM(total_views) + SUM(total_unique_views) > 0
ORDER BY contest_id;