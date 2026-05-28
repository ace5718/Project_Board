"""Tests for service helpers."""

from ..service import normalize_text


def test_normalize_text_trims_spaces():
    assert normalize_text("  hello  ") == "hello"
