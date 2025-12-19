CREATE OR REPLACE VIEW canya_event_with_slots AS
SELECT
  ce.*,
  COALESCE(
    (SELECT json_agg(s.*) FROM slot s WHERE s.canya_event = ce.id),
    '[]'
  ) as slots
FROM canya_event ce;