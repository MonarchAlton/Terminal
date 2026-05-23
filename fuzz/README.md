# Fuzzing

This directory contains fuzzing targets for narrow input boundaries.

Fuzzing should target parsers, validators, decoders, and contract deserialisation logic.

Good fuzz targets:

- market data message parser,
- scenario file parser,
- API DTO deserialisation,
- pricing request validation,
- risk request validation.

Avoid fuzzing the whole application.