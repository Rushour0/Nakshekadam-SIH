// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

/// Demonstrates how to convert a json content to tree, allowing user to
/// modify the content and see how it affects the tree.
class TreeFromJson extends StatefulWidget {
  @override
  _TreeFromJsonState createState() => _TreeFromJsonState();
}

class _TreeFromJsonState extends State<TreeFromJson> {
  final TreeController _treeController =
      TreeController(allNodesExpanded: false);
  final TextEditingController _textController = TextEditingController(text: '''
{
    "Streams": {
        "STEM": {
            "Bachelor of Architecture": {
                "link": "https://collegedunia.com/courses/bachelor-of-architecture-barch",
                "Masters of Architecture": {
                    "Jobs": "Architect"
                },
                "Jobs": "Architect"
            },
            "Bachelor of Planning": {
                "link": "https://collegedunia.com/courses/bachelor-of-planning",
                "Masters of Planning": {
                    "Jobs": {
                        "Urban Planner": null,
                        "Project Planner": null
                    }
                },
                "Jobs": {
                    "Urban Planner": null,
                    "Project Planner": null
                }
            },
            "Bachelor of Engineering/ Bachelor of Technology/ Bachelor of Science": {
                "link": "https://collegedunia.com/courses/btech",
                "Indian Engineering Services": {
                    "Jobs": {
                        "Jobs in railway": null,
                        "Jobs in public sector company": null
                    }
                },
                "Merchant Navy": {
                    "Jobs": "Marine engineer"
                },

                "Master in Engineering(M.E.)/Masters in Technology": {
                    "Jobs": {
                        "Engineer": null,
                        "Teacher": null
                    }
                },
                "Master of Science(M.Sc.)": {
                    "Jobs": {
                        "Scientists": null,
                        "Engineer": null,
                        "Teacher": null
                    }
                },
                "Master of Business Administration(M.B.A.)": {
                    "Jobs": 
                        "Manager"
                }
            },
            "Integrated BSc + MSc": {
                "link": "https://www.careers360.com/courses/bsc-msc-dual-degree",
                "Jobs":
                    "Scientist"
            },
            "Bachelor of Computer Science": {
                "link": "https://collegedunia.com/courses/bachelors-of-computer-science-bcs",
                "Masters of Computer Application": {
                    "Jobs": "Software Professional"
                },
                "Masters of Computer Science": {
                    "Jobs": "Software Professional"
                },

                "Masters in Computer Management ": {
                    "Jobs": "Software Professional"
                },
                "Master of Business Administration(M.B.A.)": {
                    "Jobs": 
                        "Manager"
                }
            },
            "Bachelor of Computer Applications": {
                "link": "https://collegedunia.com/courses/bachelor-of-computer-applications-bca",
                "Masters of Computer Application": {
                    "Jobs": "Software Professional"
                },
                "Masters of Computer Science": {
                    "Jobs": "Software Professional"
                },

                "Masters in Computer Management ": {
                    "Jobs": "Software Professional"
                },
                "Master of Business Administration(M.B.A.)": {
                    "Jobs": 
                        "Manager"
                }
            }
            ,
            "Film and Television Institute of India": {
                "link": "https://collegedunia.com/college/5483-film-and-television-institute-of-india-ftii-pune",
                "Courses": {
                        "Direction and Screenplay Writing": null,
                        "Cinematography": null,
                        "Editing": null,
                        "Sound Recording and Sound Design": null,
                        "Art Direction and Production Design": null,
                        "Screen Acting": null,
                        "Screen Writing": null,
                        "Direction": null,
                        "Electronic Cinematography": null,
                        "Video Editing": null,
                        "Sound Recording & Television Engineering": null
                },
                "Jobs": {
                    "Director/Actor/Editor/Writer/Cinematographer": null
                }
            }
        },
        "12th Commerce": {
            "C.A. foundation": {
                "link": "https://collegedunia.com/courses/chartered-accountant"
            },
            "B.com": {
                "link": "https://collegedunia.com/courses/bachelor-of-commerce-bcom",
                "M.B.A": {
                    "link": "https://collegedunia.com/courses/master-of-business-administration-mba",
                    "Job": {
                        "Manager/ Businessman": null
                    }
                }
            }
        }
    }
}
''');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              height: 600,
              width: 400,
              child: TextField(
                maxLines: 10000,
                controller: _textController,
                decoration: InputDecoration(border: OutlineInputBorder()),
                style: TextStyle(fontFamily: "courier"),
              )),
          IconButton(
            icon: Icon(Icons.arrow_right),
            iconSize: 40,
            onPressed: () => setState(() {}),
          ),
          buildTree(),
        ],
      ),
    );
  }

  /// Builds tree or error message out of the entered content.
  Widget buildTree() {
    try {
      var parsedJson = json.decode(_textController.text);
      return TreeView(
        nodes: toTreeNodes(parsedJson),
        treeController: _treeController,
      );
    } on FormatException catch (e) {
      return Text(e.message);
    }
  }

  List<TreeNode> toTreeNodes(dynamic parsedJson) {
    if (parsedJson == null) {
      return [];
    }
    if (parsedJson is Map<String, dynamic>) {
      return parsedJson.keys
          .map((k) => TreeNode(
              content: Text(k), children: toTreeNodes(parsedJson[k])))
          .toList();
    }
    if (parsedJson is List<dynamic>) {
      return parsedJson
          .asMap()
          .map((i, element) => MapEntry(i,
              TreeNode(content: Text('[$i]:'), children: toTreeNodes(element))))
          .values
          .toList();
    }
    return [TreeNode(content: Text(parsedJson.toString()))];
  }
}
