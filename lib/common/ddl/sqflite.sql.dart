const primaryKey = 'TEXT PRIMARY KEY NOT NULL';
const notNullableText = 'TEXT NOT NULL';
const nullableText = 'TEXT';

final schemaDdl =
    '''
CREATE TABLE canya_event (
          id $primaryKey, 
          name $notNullableText,
          description $nullableText
        )
''';
