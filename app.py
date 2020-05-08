#!/usr/bin/env python

from svc.manager import create_app


app = create_app(__name__)
app.run(debug=True)
