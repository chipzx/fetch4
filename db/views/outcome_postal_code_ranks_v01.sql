SELECT o.group_id, o.postal_code, totals, row_number() OVER () AS rank
FROM   (SELECT o.group_id, a.postal_code, count(*) as totals
        FROM   outcomes o
        LEFT OUTER JOIN addresses a ON (o.address_id = a.id)
        GROUP  BY o.group_id, a.postal_code
        ORDER  BY totals DESC) o
